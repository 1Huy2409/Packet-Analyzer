<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Packet Analyzer</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: #0f1419;
            color: #e5e7eb;
        }

        /* Professional navbar with professional styling */
        .navbar {
            background: #1a1f2e;
            border-bottom: 1px solid #2a3142;
            padding: 0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 18px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #ffffff;
            letter-spacing: -0.5px;
        }

        .navbar-user {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
        }

        .logout-btn {
            padding: 8px 16px;
            background: transparent;
            border: 1px solid #3f4655;
            color: #9ca3af;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            font-size: 13px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: rgba(59, 130, 246, 0.1);
            border-color: #3b82f6;
            color: #3b82f6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        .welcome-card {
            background: #1a1f2e;
            border: 1px solid #2a3142;
            border-radius: 10px;
            padding: 32px;
            margin-bottom: 32px;
        }

        .welcome-card h1 {
            color: #ffffff;
            margin-bottom: 8px;
            font-size: 28px;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        .welcome-card p {
            color: #9ca3af;
            font-size: 15px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: #1a1f2e;
            border: 1px solid #2a3142;
            border-radius: 10px;
            padding: 24px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            border-color: #3f4655;
            background: #1e232f;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: 700;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
        }

        .stat-card .label {
            color: #9ca3af;
            font-size: 13px;
            font-weight: 500;
            letter-spacing: 0.3px;
        }

        .section-title {
            color: #ffffff;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            letter-spacing: -0.3px;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .feature-card {
            background: #1a1f2e;
            border: 1px solid #2a3142;
            border-radius: 10px;
            padding: 24px;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #3b82f6 0%, #2563eb 100%);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            border-color: #3f4655;
            background: #1e232f;
            transform: translateY(-2px);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            font-size: 36px;
            margin-bottom: 12px;
        }

        .feature-card h3 {
            color: #ffffff;
            margin-bottom: 8px;
            font-size: 16px;
            font-weight: 600;
        }

        .feature-card p {
            color: #9ca3af;
            font-size: 13px;
            line-height: 1.6;
            margin-bottom: 16px;
        }

        .feature-card .btn {
            display: inline-block;
            padding: 8px 16px;
            background: #3b82f6;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            font-size: 13px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .feature-card .btn:hover {
            background: #2563eb;
            transform: translateX(2px);
        }

        /* Files Table Styles */
        .files-table-container {
            background: #1a1f2e;
            border: 1px solid #2a3142;
            border-radius: 10px;
            overflow: hidden;
        }

        .files-table {
            width: 100%;
            border-collapse: collapse;
        }

        .files-table thead {
            background: #151925;
        }

        .files-table th {
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            color: #9ca3af;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #2a3142;
        }

        .files-table tbody tr {
            border-bottom: 1px solid #2a3142;
            transition: background 0.2s ease;
        }

        .files-table tbody tr:last-child {
            border-bottom: none;
        }

        .files-table tbody tr:hover {
            background: #1e232f;
        }

        .files-table td {
            padding: 16px 20px;
            color: #e5e7eb;
            font-size: 14px;
        }

        .file-name {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        .file-icon {
            font-size: 20px;
        }

        .time-cell {
            color: #9ca3af;
            font-size: 13px;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-done {
            background: rgba(34, 197, 94, 0.15);
            color: #22c55e;
            border: 1px solid rgba(34, 197, 94, 0.3);
        }

        .status-processing {
            background: rgba(59, 130, 246, 0.15);
            color: #3b82f6;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .status-failed {
            background: rgba(239, 68, 68, 0.15);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .status-pending {
            background: rgba(250, 204, 21, 0.15);
            color: #facc15;
            border: 1px solid rgba(250, 204, 21, 0.3);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-action {
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-view {
            background: #3b82f6;
            color: white;
        }

        .btn-view:hover {
            background: #2563eb;
            transform: translateY(-1px);
        }

        .btn-refresh {
            background: #6b7280;
            color: white;
        }

        .btn-refresh:hover {
            background: #4b5563;
        }

        .text-muted {
            color: #6b7280;
            font-size: 13px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-content">
            <div class="navbar-brand">
                📊 Packet Analyzer
            </div>
            <div class="navbar-user">
                <div class="user-info">
                    <div class="user-avatar">
                        <%= user.getUsername().substring(0, 1).toUpperCase() %>
                    </div>
                    <span style="font-weight: 500; color: #e5e7eb; font-size: 14px;"><%= user.getUsername() %></span>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng Xuất</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="welcome-card">
            <h1>👋 Xin chào, <%= user.getUsername() %>!</h1>
            <p>Chào mừng bạn quay trở lại. Bắt đầu phân tích gói tin mạng của bạn ngay bây giờ.</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="number">0</div>
                <div class="label">Gói tin đã phân tích</div>
            </div>
            <div class="stat-card">
                <div class="number">${fileCount != null ? fileCount : 0}</div>
                <div class="label">File đã upload</div>
            </div>
            <div class="stat-card">
                <div class="number">0</div>
                <div class="label">Báo cáo đã tạo</div>
            </div>
        </div>

        <!-- Files List Section -->
        <c:if test="${uploadedFiles != null && uploadedFiles.size() > 0}">
            <div style="margin-bottom: 32px;">
                <h2 class="section-title">📂 File đã upload (${uploadedFiles.size()})</h2>
                <div class="files-table-container">
                    <table class="files-table">
                        <thead>
                            <tr>
                                <th>Tên File</th>
                                <th>Thời gian upload</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${uploadedFiles}" var="file">
                                <tr>
                                    <td>
                                        <div class="file-name">
                                            <span class="file-icon">📄</span>
                                            ${file.fileName}
                                        </div>
                                    </td>
                                    <td class="time-cell">${file.uploadTime}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${file.status == 'DONE'}">
                                                <span class="status-badge status-done">✓ Hoàn thành</span>
                                            </c:when>
                                            <c:when test="${file.status == 'PROCESSING'}">
                                                <span class="status-badge status-processing">⏳ Đang xử lý</span>
                                            </c:when>
                                            <c:when test="${file.status == 'FAILED'}">
                                                <span class="status-badge status-failed">✗ Lỗi</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-pending">⏸️ Chờ xử lý</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <c:if test="${file.status == 'DONE'}">
                                                <a href="${pageContext.request.contextPath}/analysis-result?fileId=${file.id}" 
                                                   class="btn-action btn-view">
                                                    🔍 Xem kết quả
                                                </a>
                                            </c:if>
                                            <c:if test="${file.status == 'PROCESSING'}">
                                                <button class="btn-action btn-refresh" onclick="location.reload()">
                                                    🔄 Làm mới
                                                </button>
                                            </c:if>
                                            <c:if test="${file.status == 'FAILED'}">
                                                <span class="text-muted">Không có kết quả</span>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <div style="margin-bottom: 32px;">
            <h2 class="section-title">Tính Năng Chính</h2>
            <div class="cards-grid">
                <div class="feature-card">
                    <div class="feature-icon">📁</div>
                    <h3>Upload File PCAP</h3>
                    <p>Tải lên file PCAP để phân tích các gói tin mạng và xem thông tin chi tiết lưu lượng.</p>
                    <a href="${pageContext.request.contextPath}/upload" class="btn">Bắt Đầu</a>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🔍</div>
                    <h3>Phân Tích Gói Tin</h3>
                    <p>Xem chi tiết các gói tin, phân tích protocol, địa chỉ nguồn/đích và nội dung dữ liệu.</p>
                    <a href="${pageContext.request.contextPath}/upload" class="btn">Phân Tích</a>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Thống Kê & Báo Cáo</h3>
                    <p>Xem thống kê lưu lượng mạng, tạo báo cáo và xuất dữ liệu phân tích chi tiết.</p>
                    <c:choose>
                        <c:when test="${fileCount > 0}">
                            <button class="btn" onclick="window.scrollTo({top: 0, behavior: 'smooth'})">Xem Báo Cáo</button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn" disabled style="opacity: 0.5; cursor: not-allowed;">Xem Báo Cáo</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
