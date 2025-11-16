<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Kiểm tra nếu đã đăng nhập thì chuyển đến dashboard
    if (session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
    } else {
        // Nếu chưa đăng nhập thì chuyển đến trang login
        response.sendRedirect(request.getContextPath() + "/login");
    }
%>
