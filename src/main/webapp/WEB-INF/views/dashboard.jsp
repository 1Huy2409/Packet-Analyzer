<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="model.bean.User" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% User user = (User) session.getAttribute("user"); if (user == null) {
response.sendRedirect(request.getContextPath() + "/login"); return; } %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Packet Analyzer</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto",
          sans-serif;
        background: #f3f4f6;
        color: #1f2937;
      }

      /* Updated navbar to light theme with white background */
      .navbar {
        background: #ffffff;
        border-bottom: 1px solid #e5e7eb;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
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
        color: #1f2937;
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

      /* Updated logout button for light theme */
      .logout-btn {
        padding: 8px 16px;
        background: transparent;
        border: 1px solid #d1d5db;
        color: #4b5563;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        font-size: 13px;
        transition: all 0.3s ease;
        cursor: pointer;
      }

      .logout-btn:hover {
        background: #f3f4f6;
        border-color: #3b82f6;
        color: #3b82f6;
      }

      .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 32px 24px;
      }

      /* Updated welcome card for light theme */
      .welcome-card {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        padding: 32px;
        margin-bottom: 32px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
      }

      .welcome-card h1 {
        color: #1f2937;
        margin-bottom: 8px;
        font-size: 28px;
        font-weight: 600;
        letter-spacing: -0.5px;
      }

      .welcome-card p {
        color: #6b7280;
        font-size: 15px;
      }

      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        margin-bottom: 32px;
      }

      /* Updated stat cards for light theme */
      .stat-card {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        padding: 24px;
        text-align: center;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
      }

      .stat-card:hover {
        border-color: #d1d5db;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        transform: translateY(-2px);
      }

      .stat-card .number {
        font-size: 32px;
        font-weight: 700;
        color: #3b82f6;
        margin-bottom: 8px;
      }

      .stat-card .label {
        color: #6b7280;
        font-size: 13px;
        font-weight: 500;
        letter-spacing: 0.3px;
      }

      .stat-card.danger .number {
        color: #ef4444;
      }

      .stat-card.success .number {
        color: #16a34a;
      }

      .section-title {
        color: #1f2937;
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        letter-spacing: -0.3px;
      }

      .cards-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
        margin-bottom: 32px;
      }

      /* Updated feature cards for light theme */
      .feature-card {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        cursor: pointer;
        position: relative;
        overflow: hidden;
      }

      .feature-card::before {
        content: "";
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
        border-color: #bfdbfe;
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1);
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
        color: #1f2937;
        margin-bottom: 8px;
        font-size: 16px;
        font-weight: 600;
      }

      .feature-card p {
        color: #6b7280;
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

      .feature-card .btn:disabled {
        background: #d1d5db;
        color: #9ca3af;
        cursor: not-allowed;
        transform: none;
      }

      /* Updated files table for light theme */
      .files-table-container {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
      }

      .files-table {
        width: 100%;
        border-collapse: collapse;
      }

      .files-table thead {
        background: #f9fafb;
        border-bottom: 1px solid #e5e7eb;
      }

      .files-table th {
        padding: 16px 20px;
        text-align: left;
        font-weight: 600;
        font-size: 13px;
        color: #6b7280;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .files-table tbody tr {
        border-bottom: 1px solid #e5e7eb;
        transition: background 0.2s ease;
      }

      .files-table tbody tr:last-child {
        border-bottom: none;
      }

      .files-table tbody tr:hover {
        background: #f9fafb;
      }

      .files-table td {
        padding: 16px 20px;
        color: #1f2937;
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
        color: #6b7280;
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
        background: rgba(34, 197, 94, 0.1);
        color: #16a34a;
        border: 1px solid rgba(34, 197, 94, 0.3);
      }

      .status-processing {
        background: rgba(59, 130, 246, 0.1);
        color: #3b82f6;
        border: 1px solid rgba(59, 130, 246, 0.3);
      }

      .status-failed {
        background: rgba(239, 68, 68, 0.1);
        color: #ef4444;
        border: 1px solid rgba(239, 68, 68, 0.3);
      }

      .status-pending {
        background: rgba(250, 204, 21, 0.1);
        color: #ca8a04;
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
        background: #e5e7eb;
        color: #4b5563;
      }

      .btn-refresh:hover {
        background: #d1d5db;
      }

      .text-muted {
        color: #9ca3af;
        font-size: 13px;
        font-style: italic;
      }

      /* Responsive design */
      @media (max-width: 768px) {
        .navbar-content {
          flex-direction: column;
          gap: 12px;
        }

        .container {
          padding: 20px 16px;
        }

        .stats-grid {
          grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        }

        .cards-grid {
          grid-template-columns: 1fr;
        }

        .files-table {
          font-size: 12px;
        }

        .files-table td,
        .files-table th {
          padding: 12px 16px;
        }
      }
    </style>
  </head>
  <body>
    <nav class="navbar">
      <div class="navbar-content">
        <div class="navbar-brand">📊 Packet Analyzer</div>
        <div class="navbar-user">
          <div class="user-info">
            <div class="user-avatar">
              <%= user.getUsername().substring(0, 1).toUpperCase() %>
            </div>
            <span style="font-weight: 500; color: #1f2937; font-size: 14px"
              ><%= user.getUsername() %></span
            >
          </div>
          <a href="${pageContext.request.contextPath}/logout" class="logout-btn"
            >Đăng Xuất</a
          >
        </div>
      </div>
    </nav>

    <div class="container">
      <div class="welcome-card">
        <h1>👋 Xin chào, <%= user.getUsername() %>!</h1>
        <p>
          Chào mừng bạn quay trở lại. Bắt đầu phân tích gói tin mạng của bạn
          ngay bây giờ.
        </p>
      </div>

      <!-- Statistics Cards -->
      <div class="stats-grid">
        <!-- <div class="stat-card">
          <div class="number">0</div>
          <div class="label">Gói tin đã phân tích</div>
        </div> -->
        <div class="stat-card">
          <div class="number">${fileCount != null ? fileCount : 0}</div>
          <div class="label">File đã upload</div>
        </div>
        <!-- <div class="stat-card success">
          <div class="number">0</div>
          <div class="label">Báo cáo đã tạo</div>
        </div> -->
      </div>

      <!-- Main Features Section -->
      <div style="margin-bottom: 32px">
        <h2 class="section-title">Tính Năng Chính</h2>
        <div class="cards-grid">
          <div class="feature-card">
            <div class="feature-icon">📁</div>
            <h3>Upload File PCAP</h3>
            <p>
              Tải lên file PCAP để phân tích các gói tin mạng và xem thông tin
              chi tiết lưu lượng.
            </p>
            <a href="${pageContext.request.contextPath}/upload" class="btn"
              >Bắt Đầu</a
            >
          </div>

          <div class="feature-card">
            <div class="feature-icon">🔍</div>
            <h3>Phân Tích Gói Tin</h3>
            <p>Kết quả phân tích chi tiết thông tin của từng gói tin</p>
            <a
              href="${pageContext.request.contextPath}/analysis-files"
              class="btn"
              >Xem File Đã Upload</a
            >
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
