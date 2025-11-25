package controller;

import model.bean.FileUpload;
import model.bean.User;
import model.bo.FileUploadBO;
import model.worker.AnalyzerWorker;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.stream.Collectors;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 500, // 500MB
        maxRequestSize = 1500L * 1024L * 1024L // 1.5GB
)
public class FileUploadServlet extends HttpServlet {
    private FileUploadBO fileUploadBO;
    // Thư mục lưu file cố định, ngoài target để không bị mất khi build lại
    private static final String UPLOAD_DIR = System.getProperty("user.dir") + File.separator + "uploads";

    @Override
    public void init() throws ServletException {
        fileUploadBO = new FileUploadBO();
        // Tạo thư mục uploads nếu chưa tồn tại
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Created upload directory: " + UPLOAD_DIR);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy danh sách file vừa upload trong session và refresh status từ DB
        @SuppressWarnings("unchecked")
        List<FileUpload> sessionFiles = (List<FileUpload>) session.getAttribute("recentUploadedFiles");
        if (sessionFiles != null && !sessionFiles.isEmpty()) {
            // Refresh status từ DB cho các file trong session
            List<FileUpload> refreshedFiles = new ArrayList<>();
            boolean hasProcessing = false;
            boolean allCompleted = true;
            int completedCount = 0;
            for (FileUpload file : sessionFiles) {
                FileUpload dbFile = fileUploadBO.getFileById(file.getId());
                if (dbFile != null) {
                    // Cập nhật status và uploadTime từ DB
                    file.setStatus(dbFile.getStatus());
                    file.setUploadTime(dbFile.getUploadTime());
                    refreshedFiles.add(file);
                    if ("PROCESSING".equals(file.getStatus()) || "PENDING".equals(file.getStatus())) {
                        hasProcessing = true;
                        allCompleted = false;
                    }
                    if ("COMPLETED".equals(file.getStatus())) {
                        completedCount++;
                    } else {
                        allCompleted = false;
                    }
                } else {
                    // Nếu file không còn trong DB, bỏ qua
                    refreshedFiles.add(file);
                }
            }
            // Cập nhật lại session với danh sách đã refresh
            session.setAttribute("recentUploadedFiles", refreshedFiles);
            request.setAttribute("files", refreshedFiles);
            // Nếu tất cả file đã COMPLETED, hiển thị thông báo thành công
            if (allCompleted && completedCount > 0) {
                request.setAttribute("success", String.format("✓ Upload thành công %d file!", completedCount));
            } else if (hasProcessing) {
                // Nếu còn file đang xử lý, giữ thông báo 'Đang phân tích...'
                request.setAttribute("success", "⏳ Đang phân tích...");
            }
        } else {
            sessionFiles = new ArrayList<>();
            request.setAttribute("files", sessionFiles);
        }

        request.getRequestDispatcher("/WEB-INF/views/upload.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            // Lấy tất cả file parts từ request (hỗ trợ multiple files)
            List<Part> fileParts = request.getParts().stream()
                    .filter(part -> "files".equals(part.getName()) && part.getSize() > 0)
                    .collect(Collectors.toList());

            if (fileParts.isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn ít nhất một file để upload!");
                doGet(request, response);
                return;
            }

            int successCount = 0;
            int failCount = 0;
            ExecutorService executor = (ExecutorService) getServletContext().getAttribute("analyzerExecutor");
            
            // Lấy danh sách file trong session
            @SuppressWarnings("unchecked")
            List<FileUpload> sessionFiles = (List<FileUpload>) session.getAttribute("recentUploadedFiles");
            if (sessionFiles == null) {
                sessionFiles = new ArrayList<>();
            }

            // Xử lý từng file
            for (Part filePart : fileParts) {
                try {
                    String fileName = getFileName(filePart);

                    // Kiểm tra định dạng file
                    if (!isValidFileType(fileName)) {
                        System.out.println("Skipped invalid file type: " + fileName);
                        failCount++;
                        continue;
                    }

                    // Tạo tên file unique
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    Path filePath = Paths.get(UPLOAD_DIR, uniqueFileName);

                    // Lưu file vào disk
                    try (java.io.InputStream inputStream = filePart.getInputStream()) {
                        Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
                    }

                    System.out.println("File saved to: " + filePath.toAbsolutePath());

                    // Lưu thông tin vào database
                    FileUpload fileUpload = new FileUpload();
                    fileUpload.setUserId(user.getId());
                    fileUpload.setFileName(uniqueFileName);
                    fileUpload.setFileSize(filePart.getSize());
                    fileUpload.setStatus("PENDING");

                    if (fileUploadBO.saveFileUpload(fileUpload)) {
                        System.out.println("File uploaded successfully: " + uniqueFileName);

                        // Lấy lại file từ DB để có đầy đủ thông tin (bao gồm upload_time)
                        FileUpload savedFile = fileUploadBO.getFileById(fileUpload.getId());
                        if (savedFile != null) {
                            sessionFiles.add(savedFile);
                        } else {
                            sessionFiles.add(fileUpload);
                        }

                        // Đẩy job phân tích qua BO
                        fileUploadBO.submitAnalysisJob(fileUpload.getId(), filePath.toAbsolutePath().toString(), executor);
                        successCount++;
                    } else {
                        // Xóa file nếu lưu database thất bại
                        Files.deleteIfExists(filePath);
                        failCount++;
                    }

                } catch (Exception e) {
                    System.out.println("Error processing file: " + e.getMessage());
                    e.printStackTrace();
                    failCount++;
                } finally {
                    // Cleanup file part
                    try {
                        filePart.delete();
                    } catch (Exception e) {
                        // Ignore
                    }
                }
            }

            // Lưu danh sách file vào session
            session.setAttribute("recentUploadedFiles", sessionFiles);

            // Hiển thị thông báo kết quả
            if (successCount > 0 && failCount == 0) {
                request.setAttribute("success",
                        String.format("✓ Upload thành công %d file! Đang phân tích...", successCount));
            } else if (successCount > 0 && failCount > 0) {
                request.setAttribute("success",
                        String.format("Upload thành công %d file, thất bại %d file", successCount, failCount));
            } else {
                request.setAttribute("error", "Không thể upload file. Vui lòng kiểm tra định dạng file!");
            }

        } catch (Exception e) {
            System.out.println("Upload error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi upload file: " + e.getMessage());
        }

        // doGet(request, response);
        response.sendRedirect(request.getContextPath() + "/upload");

    }

    // Lấy tên file từ Part
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    // Kiểm tra định dạng file
    private boolean isValidFileType(String fileName) {
        String lowerFileName = fileName.toLowerCase();
        return lowerFileName.endsWith(".pcap") ||
                lowerFileName.endsWith(".pcapng") ||
                lowerFileName.endsWith(".cap") ||
                lowerFileName.endsWith(".log") ||
                lowerFileName.endsWith(".txt") ||
                lowerFileName.endsWith(".csv");
    }
}
