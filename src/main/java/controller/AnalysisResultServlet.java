package controller;

import model.bean.AnalysisResult;
import model.bean.FileUpload;
import model.bean.User;
import model.bo.AnalysisResultBO;
import model.bo.FileUploadBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/analysis-result")
public class AnalysisResultServlet extends HttpServlet {
    private AnalysisResultBO analysisResultBO;
    private FileUploadBO fileUploadBO;

    @Override
    public void init() throws ServletException {
        analysisResultBO = new AnalysisResultBO();
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

        String fileIdStr = request.getParameter("fileId");

        if (fileIdStr == null || fileIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/upload");
            return;
        }

        try {
            int fileId = Integer.parseInt(fileIdStr);

            // Lấy thông tin file
            FileUpload file = fileUploadBO.getFileById(fileId);
            if (file == null) {
                request.setAttribute("error", "File không tồn tại!");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Kiểm tra quyền truy cập
            User user = (User) session.getAttribute("user");
            if (file.getUserId() != user.getId()) {
                request.setAttribute("error", "Bạn không có quyền xem kết quả này!");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Lấy kết quả phân tích
            AnalysisResult result = analysisResultBO.getResultByFileId(fileId);

            request.setAttribute("file", file);
            request.setAttribute("result", result);

            request.getRequestDispatcher("/WEB-INF/views/analysis-result.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/upload");
        }
    }
}
