<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.User" %>
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
                    <button class="btn">Phân Tích</button>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Thống Kê & Báo Cáo</h3>
                    <p>Xem thống kê lưu lượng mạng, tạo báo cáo và xuất dữ liệu phân tích chi tiết.</p>
                    <button class="btn">Xem Báo Cáo</button>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">⚙️</div>
                    <h3>Cài Đặt</h3>
                    <p>Quản lý tài khoản, thay đổi mật khẩu và cấu hình hệ thống theo nhu cầu.</p>
                    <button class="btn">Cài Đặt</button>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">📖</div>
                    <h3>Hướng Dẫn</h3>
                    <p>Xem hướng dẫn sử dụng hệ thống và tài liệu về phân tích gói tin mạng.</p>
                    <button class="btn">Tìm Hiểu</button>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">💬</div>
                    <h3>Hỗ Trợ</h3>
                    <p>Liên hệ đội ngũ hỗ trợ nếu bạn gặp vấn đề hoặc cần trợ giúp hệ thống.</p>
                    <button class="btn">Liên Hệ</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
