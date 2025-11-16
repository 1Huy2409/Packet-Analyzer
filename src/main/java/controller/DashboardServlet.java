package controller;

import model.bean.User;
import model.bo.FileUploadBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private FileUploadBO fileUploadBO;

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

        // Lấy thông tin user và đếm số file
        User user = (User) session.getAttribute("user");
        int fileCount = fileUploadBO.countFilesByUserId(user.getId());
        request.setAttribute("fileCount", fileCount);

        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
}
