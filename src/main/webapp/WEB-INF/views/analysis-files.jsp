<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Phân Tích Gói Tin - Packet Analyzer</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto",
          "Oxygen", "Ubuntu", "Cantarell", sans-serif;
        background: linear-gradient(135deg, #f5f7fa 0%, #f0f2f8 100%);
        min-height: 100vh;
        padding: 40px 20px;
      }

      .container {
        max-width: 1200px;
        margin: 0 auto;
      }

      .header {
        background: white;
        padding: 30px 40px;
        border-radius: 16px;
        margin-bottom: 40px;
        box-shadow: 0 4px 20px rgba(0, 15, 52, 0.08);
        display: flex;
        justify-content: space-between;
        align-items: center;
        backdrop-filter: blur(10px);
      }

      .header h1 {
        color: #000f34;
        font-size: 32px;
        font-weight: 700;
        letter-spacing: -0.5px;
      }

      .user-info {
        display: flex;
        align-items: center;
        gap: 20px;
      }

      .user-info span {
        color: #667177;
        font-weight: 500;
        font-size: 14px;
      }

      /* Modern button styles with hover effects */
      .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
        font-weight: 600;
        letter-spacing: 0.3px;
      }

      .btn-primary {
        background: linear-gradient(135deg, #1e40af 0%, #1e3a8a 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(30, 64, 175, 0.2);
      }

      .btn-primary:hover {
        background: linear-gradient(135deg, #1e3a8a 0%, #172554 100%);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(30, 64, 175, 0.3);
      }

      .btn-secondary {
        background: #e8ebf0;
        color: #000f34;
        box-shadow: none;
      }

      .btn-secondary:hover {
        background: #d4dce7;
        transform: translateY(-2px);
      }

      /* Modern files section styling */
      .files-section {
        background: white;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0, 15, 52, 0.08);
      }

      .files-section h2 {
        color: #000f34;
        margin-bottom: 24px;
        font-size: 24px;
        font-weight: 700;
        letter-spacing: -0.3px;
      }

      .files-table {
        width: 100%;
        border-collapse: collapse;
      }

      .files-table th,
      .files-table td {
        padding: 16px;
        text-align: left;
        border-bottom: 1px solid #e5e7eb;
      }

      .files-table th {
        background: transparent;
        color: #667177;
        font-weight: 700;
        font-size: 13px;
        letter-spacing: 0.5px;
        text-transform: uppercase;
      }

      .files-table tr:hover {
        background: linear-gradient(90deg, #f8f9fb 0%, #f5f7fa 100%);
      }

      .status-badge {
        padding: 6px 14px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 700;
        display: inline-block;
      }

      .status-completed {
        background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
        color: #065f46;
      }

      .status-processing {
        background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
        color: #1e40af;
      }

      .status-pending {
        background: linear-gradient(135deg, #fef3c7 0%, #fcd34d 100%);
        color: #92400e;
      }

      .status-failed {
        background: linear-gradient(135deg, #fee2e2 0%, #fca5a5 100%);
        color: #7f1d1d;
      }

      .no-files {
        text-align: center;
        padding: 60px 40px;
        color: #9ca3af;
      }

      @media (max-width: 768px) {
        .header {
          flex-direction: column;
          gap: 20px;
          text-align: center;
        }

        .user-info {
          flex-direction: column;
          width: 100%;
        }

        .files-table th,
        .files-table td {
          padding: 12px;
          font-size: 13px;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <!-- Header -->
      <div class="header">
        <h1>🔍 Phân Tích Gói Tin</h1>
        <div class="user-info">
          <span>👤 ${sessionScope.username}</span>
          <a
            href="${pageContext.request.contextPath}/dashboard"
            class="btn btn-secondary"
            >Dashboard</a
          >
          <a
            href="${pageContext.request.contextPath}/upload"
            class="btn btn-secondary"
            >Upload File</a
          >
          <a
            href="${pageContext.request.contextPath}/logout"
            class="btn btn-secondary"
            >Logout</a
          >
        </div>
      </div>

      <!-- Files List -->
      <div class="files-section">
        <h2>📋 Danh sách file đã upload</h2>
        <c:choose>
          <c:when test="${not empty files}">
            <table class="files-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Tên file</th>
                  <th>Thời gian upload</th>
                  <th>Trạng thái</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="file" items="${files}" varStatus="status">
                  <tr>
                    <td>${status.count}</td>
                    <td>${file.fileName}</td>
                    <td>${file.uploadTime}</td>
                    <td>
                      <span
                        class="status-badge status-${file.status.toLowerCase()}"
                      >
                        ${file.status}
                      </span>
                    </td>
                    <td>
                      <a
                        href="${pageContext.request.contextPath}/analysis-result?fileId=${file.id}"
                        class="btn btn-primary"
                        style="padding: 8px 16px; font-size: 13px"
                      >
                        📊 Xem kết quả
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <div class="no-files">
              <div style="font-size: 48px; margin-bottom: 16px">📂</div>
              <p style="font-size: 16px; color: #667177; font-weight: 500">
                Chưa có file nào được upload
              </p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </body>
</html>
