package controller;

import model.bean.FileUpload;
import model.bean.User;
import model.bo.FileUploadBO;

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
import java.util.List;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 500, // 500MB
        maxRequestSize = 1024 * 1024 * 1024 // 1GB
)
public class FileUploadServlet extends HttpServlet {
    private FileUploadBO fileUploadBO;
    private static final String UPLOAD_DIR = "uploads";

    @Override
    public void init() throws ServletException {
        fileUploadBO = new FileUploadBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy danh sách file đã upload
        User user = (User) session.getAttribute("user");
        List<FileUpload> files = fileUploadBO.getFilesByUserId(user.getId());
        request.setAttribute("files", files);

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
        Part filePart = null;

        try {
            // Lấy file từ request
            filePart = request.getPart("file");

            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("error", "Vui lòng chọn file để upload!");
                doGet(request, response);
                return;
            }

            String fileName = getFileName(filePart);

            // Kiểm tra định dạng file (chỉ cho phép .pcap, .pcapng, .cap, .log, .txt, .csv)
            if (!isValidFileType(fileName)) {
                request.setAttribute("error", "Chỉ chấp nhận file .pcap, .pcapng, .cap, .log, .txt, .csv!");
                doGet(request, response);
                return;
            }

            // Tạo thư mục upload nếu chưa tồn tại
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Tạo tên file unique để tránh trùng lặp
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            Path filePath = Paths.get(uploadPath, uniqueFileName);

            // Lưu file vào thư mục uploads với try-with-resources để đảm bảo đóng stream
            try (java.io.InputStream inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            // Lưu thông tin vào database
            FileUpload fileUpload = new FileUpload();
            fileUpload.setUserId(user.getId());
            fileUpload.setFileName(uniqueFileName);
            fileUpload.setFileSize(filePart.getSize());
            fileUpload.setStatus("COMPLETED");

            if (fileUploadBO.saveFileUpload(fileUpload)) {
                System.out.println("File uploaded successfully: " + uniqueFileName);
                request.setAttribute("success", "Upload file thành công!");
            } else {
                // Xóa file nếu lưu database thất bại
                Files.deleteIfExists(filePath);
                request.setAttribute("error", "Lỗi khi lưu thông tin file!");
            }

        } catch (Exception e) {
            System.out.println("Upload error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi upload file: " + e.getMessage());
        } finally {
            // Đảm bảo xóa file Part để giải phóng tài nguyên
            if (filePart != null) {
                try {
                    filePart.delete();
                } catch (Exception e) {
                    // Ignore - Tomcat sẽ tự dọn dẹp
                }
            }
        }

        doGet(request, response);
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
