<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kết quả phân tích - ${file.fileName}</title>
    <style>
      /* Reset */
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto",
          sans-serif;
        background-color: #f3f4f6;
        color: #374151;
        min-height: 100vh;
        padding: 24px 20px;
      }

      .container {
        max-width: 1400px;
        margin: 0 auto;
      }

      /* Converted to light theme header */
      .header {
        background: #ffffff;
        padding: 20px 28px;
        border-radius: 12px;
        margin-bottom: 28px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
      }

      .header h1 {
        color: #111827;
        font-size: 24px;
        font-weight: 700;
        letter-spacing: -0.02em;
      }

      .header-actions {
        display: flex;
        gap: 12px;
      }

      /* Refined button styling for light theme */
      .btn {
        padding: 10px 18px;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.2s ease;
        white-space: nowrap;
      }

      .btn-primary {
        background: #2563eb;
        color: white;
      }

      .btn-primary:hover {
        background: #1d4ed8;
      }

      .btn-secondary {
        background: #e5e7eb;
        color: #374151;
      }

      .btn-secondary:hover {
        background: #d1d5db;
      }

      /* File info card with light theme */
      .file-info-card {
        background: #ffffff;
        padding: 24px;
        border-radius: 12px;
        margin-bottom: 24px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        border: 1px solid #e5e7eb;
      }

      .file-info-card h2 {
        color: #111827;
        font-size: 16px;
        font-weight: 700;
        margin-bottom: 16px;
        padding-bottom: 12px;
        border-bottom: 1px solid #e5e7eb;
      }

      .file-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
      }

      .file-detail-item {
        display: flex;
        flex-direction: column;
      }

      .file-detail-label {
        font-size: 12px;
        color: #6b7280;
        margin-bottom: 6px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .file-detail-value {
        font-size: 15px;
        color: #111827;
        font-weight: 600;
        word-break: break-word;
      }

      /* Status badges with light theme colors */
      .status-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        width: fit-content;
      }

      .status-processing {
        background: #fef3c7;
        color: #92400e;
      }

      .status-done {
        background: #dcfce7;
        color: #166534;
      }

      .status-failed {
        background: #fee2e2;
        color: #991b1b;
      }

      /* Stats grid with responsive layout */
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        margin-bottom: 24px;
      }

      .stat-card {
        background: #ffffff;
        padding: 22px;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        border: 1px solid #e5e7eb;
        transition: all 0.2s ease;
      }

      .stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      }

      .stat-icon {
        font-size: 28px;
        margin-bottom: 12px;
      }

      .stat-label {
        font-size: 12px;
        color: #6b7280;
        margin-bottom: 8px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .stat-value {
        font-size: 26px;
        color: #111827;
        font-weight: 700;
      }

      .stat-unit {
        font-size: 13px;
        color: #9ca3af;
        margin-left: 4px;
        font-weight: 500;
      }

      /* Detailed stats section */
      .detailed-stats {
        background: #ffffff;
        padding: 28px;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        border: 1px solid #e5e7eb;
        margin-bottom: 24px;
      }

      .detailed-stats h2 {
        color: #111827;
        font-size: 16px;
        font-weight: 700;
        margin-bottom: 20px;
        padding-bottom: 12px;
        border-bottom: 1px solid #e5e7eb;
      }

      .stats-table {
        width: 100%;
        border-collapse: collapse;
      }

      .stats-table tr {
        border-bottom: 1px solid #e5e7eb;
      }

      .stats-table tr:last-child {
        border-bottom: none;
      }

      .stats-table td {
        padding: 14px 0;
      }

      .stats-table td:first-child {
        color: #6b7280;
        font-weight: 500;
        width: 50%;
      }

      .stats-table td:last-child {
        color: #111827;
        font-weight: 600;
        text-align: right;
      }

      /* Protocol distribution section */
      .protocol-chart {
        background: #ffffff;
        padding: 28px;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        border: 1px solid #e5e7eb;
      }

      .protocol-chart h2 {
        color: #111827;
        font-size: 16px;
        font-weight: 700;
        margin-bottom: 24px;
        padding-bottom: 12px;
        border-bottom: 1px solid #e5e7eb;
      }

      .protocol-item {
        margin-bottom: 24px;
      }

      .protocol-item:last-child {
        margin-bottom: 0;
      }

      .protocol-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
      }

      .protocol-name {
        font-weight: 600;
        color: #111827;
        font-size: 14px;
      }

      .protocol-count {
        color: #6b7280;
        font-weight: 500;
        font-size: 14px;
      }

      .protocol-bar {
        height: 28px;
        background: #f3f4f6;
        border-radius: 8px;
        overflow: hidden;
        position: relative;
      }

      .protocol-fill {
        height: 100%;
        border-radius: 8px;
        transition: width 0.5s ease;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding-right: 12px;
        color: white;
        font-weight: 600;
        font-size: 12px;
      }

      .protocol-tcp {
        background: linear-gradient(90deg, #2563eb 0%, #1d4ed8 100%);
      }

      .protocol-udp {
        background: linear-gradient(90deg, #0891b2 0%, #0e7490 100%);
      }

      .protocol-other {
        background: linear-gradient(90deg, #7c3aed 0%, #6d28d9 100%);
      }

      /* No result state styling */
      .no-result {
        background: #ffffff;
        padding: 48px 32px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        border: 1px solid #e5e7eb;
      }

      .no-result-icon {
        font-size: 64px;
        margin-bottom: 16px;
      }

      .no-result h2 {
        color: #111827;
        margin-bottom: 8px;
        font-size: 18px;
        font-weight: 700;
      }

      .no-result p {
        color: #6b7280;
        font-size: 15px;
      }

      .no-result .btn {
        margin-top: 20px;
      }

      /* Responsive */
      @media (max-width: 768px) {
        body {
          padding: 16px 12px;
        }

        .container {
          max-width: 100%;
        }

        .header {
          flex-direction: column;
          align-items: flex-start;
          gap: 12px;
        }

        .header h1 {
          font-size: 20px;
        }

        .header-actions {
          width: 100%;
          flex-wrap: wrap;
        }

        .stats-grid {
          grid-template-columns: 1fr;
        }

        .file-details {
          grid-template-columns: 1fr;
        }

        .file-info-card,
        .detailed-stats,
        .protocol-chart {
          padding: 18px 16px;
        }

        .stat-card {
          padding: 18px 16px;
        }

        .stat-value {
          font-size: 22px;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <!-- Header -->
      <div class="header">
        <h1>📊 Kết quả phân tích</h1>
        <div class="header-actions">
          <a
            href="${pageContext.request.contextPath}/analysis-files"
            class="btn btn-secondary"
          >
            ← Quay lại
          </a>
          <a
            href="${pageContext.request.contextPath}/dashboard"
            class="btn btn-primary"
          >
            🏠 Dashboard
          </a>
        </div>
      </div>

      <!-- File Info -->
      <div class="file-info-card">
        <h2>📁 Thông tin file</h2>
        <div class="file-details">
          <!-- fileName -->
          <div class="file-detail-item">
            <span class="file-detail-label">Tên file</span>
            <span class="file-detail-value">${file.fileName}</span>
          </div>
          <!-- uploadTime -->
          <div class="file-detail-item">
            <span class="file-detail-label">Thời gian upload</span>
            <span class="file-detail-value">${file.uploadTime}</span>
          </div>
          <!-- status -->
          <div class="file-detail-item">
            <span class="file-detail-label">Trạng thái</span>
            <span class="status-badge status-${file.status.toLowerCase()}"
              >${file.status}</span
            >
          </div>
          <!-- processingTime -->
          <c:if test="${result != null}">
            <div class="file-detail-item">
              <span class="file-detail-label">Thời gian xử lý</span>
              <span class="file-detail-value"
                >${result.processingTimeMs} ms</span
              >
            </div>
          </c:if>
        </div>
      </div>

      <c:choose>
        <c:when test="${result != null}">
          <!-- Stats Grid -->
          <div class="stats-grid">
            <!-- flowsCount -->
            <div class="stat-card">
              <div class="stat-icon">📦</div>
              <div class="stat-label">Tổng số flows</div>
              <div class="stat-value">
                <fmt:formatNumber value="${result.totalFlows}" type="number" />
              </div>
            </div>

            <!-- totalBytesSent -->
            <div class="stat-card">
              <div class="stat-icon">⬆️</div>
              <div class="stat-label">Tổng bytes gửi</div>
              <div class="stat-value">
                <fmt:formatNumber
                  value="${result.totalBytesSent}"
                  type="number"
                />
                <span class="stat-unit">bytes</span>
              </div>
            </div>

            <!-- totalBytesReceived -->
            <div class="stat-card">
              <div class="stat-icon">⬇️</div>
              <div class="stat-label">Tổng bytes nhận</div>
              <div class="stat-value">
                <fmt:formatNumber
                  value="${result.totalBytesReceived}"
                  type="number"
                />
                <span class="stat-unit">bytes</span>
              </div>
            </div>

            <!-- avgThroughputSent -->
            <div class="stat-card">
              <div class="stat-icon">⚡</div>
              <div class="stat-label">Throughput gửi TB</div>
              <div class="stat-value">
                <fmt:formatNumber
                  value="${result.avgThroughputSent}"
                  maxFractionDigits="2"
                />
                <span class="stat-unit">Bps</span>
              </div>
            </div>
          </div>

          <!-- Detailed Stats -->
          <div class="detailed-stats">
            <h2>📈 Thống kê chi tiết</h2>
            <table class="stats-table">
              <!-- avgThroughputReceive -->
              <tr>
                <td>Throughput nhận trung bình</td>
                <td>
                  <fmt:formatNumber
                    value="${result.avgThroughputReceive}"
                    maxFractionDigits="2"
                  />
                  Bps
                </td>
              </tr>
              <!-- avgRtt -->
              <tr>
                <td>RTT trung bình</td>
                <td>
                  <fmt:formatNumber
                    value="${result.avgRtt}"
                    maxFractionDigits="2"
                  />
                  ms
                </td>
              </tr>
              <!-- avgFlowDuration -->
              <tr>
                <td>Thời gian flow trung bình</td>
                <td>
                  <fmt:formatNumber
                    value="${result.avgFlowDuration}"
                    maxFractionDigits="2"
                  />
                  s
                </td>
              </tr>
              <!-- avgPacketSize -->
              <tr>
                <td>Kích thước gói trung bình</td>
                <td>
                  <fmt:formatNumber
                    value="${result.avgPacketSizeMean}"
                    maxFractionDigits="2"
                  />
                  bytes
                </td>
              </tr>
            </table>
          </div>

          <!-- Protocol Distribution -->
          <div class="protocol-chart">
            <h2>🔌 Phân bố Protocol</h2>

            <c:set
              var="totalProtocol"
              value="${result.tcpFlows + result.udpFlows + result.otherFlows}"
            />

            <c:choose>
              <c:when test="${totalProtocol > 0}">
                <!-- tcpFlows -->
                <c:set
                  var="tcpPercent"
                  value="${result.tcpFlows * 100.0 / totalProtocol}"
                />
                <div class="protocol-item">
                  <div class="protocol-header">
                    <span class="protocol-name">TCP</span>
                    <span class="protocol-count">${result.tcpFlows} flows</span>
                  </div>
                  <div class="protocol-bar">
                    <div
                      class="protocol-fill protocol-tcp"
                      style="width: ${tcpPercent}%"
                    >
                      <fmt:formatNumber
                        value="${tcpPercent}"
                        maxFractionDigits="1"
                      />%
                    </div>
                  </div>
                </div>

                <!-- udpFlows -->
                <c:set
                  var="udpPercent"
                  value="${result.udpFlows * 100.0 / totalProtocol}"
                />
                <div class="protocol-item">
                  <div class="protocol-header">
                    <span class="protocol-name">UDP</span>
                    <span class="protocol-count">${result.udpFlows} flows</span>
                  </div>
                  <div class="protocol-bar">
                    <div
                      class="protocol-fill protocol-udp"
                      style="width: ${udpPercent}%"
                    >
                      <fmt:formatNumber
                        value="${udpPercent}"
                        maxFractionDigits="1"
                      />%
                    </div>
                  </div>
                </div>

                <!-- otherFlows -->
                <c:if test="${result.otherFlows > 0}">
                  <c:set
                    var="otherPercent"
                    value="${result.otherFlows * 100.0 / totalProtocol}"
                  />
                  <div class="protocol-item">
                    <div class="protocol-header">
                      <span class="protocol-name">Khác</span>
                      <span class="protocol-count"
                        >${result.otherFlows} flows</span
                      >
                    </div>
                    <div class="protocol-bar">
                      <div
                        class="protocol-fill protocol-other"
                        style="width: ${otherPercent}%"
                      >
                        <fmt:formatNumber
                          value="${otherPercent}"
                          maxFractionDigits="1"
                        />%
                      </div>
                    </div>
                  </div>
                </c:if>
              </c:when>
              <c:otherwise>
                <p style="text-align: center; color: #9ca3af; padding: 24px">
                  Không có dữ liệu protocol
                </p>
              </c:otherwise>
            </c:choose>
          </div>
        </c:when>
        <c:otherwise>
          <!-- No Result -->
          <div class="no-result">
            <div class="no-result-icon">
              <c:choose>
                <c:when test="${file.status == 'PROCESSING'}">⏳</c:when>
                <c:when test="${file.status == 'FAILED'}">❌</c:when>
                <c:otherwise>⏸️</c:otherwise>
              </c:choose>
            </div>
            <h2>
              <c:choose>
                <c:when test="${file.status == 'PROCESSING'}"
                  >Đang xử lý...</c:when
                >
                <c:when test="${file.status == 'FAILED'}"
                  >Phân tích thất bại</c:when
                >
                <c:otherwise>Chưa có kết quả phân tích</c:otherwise>
              </c:choose>
            </h2>
            <p>
              <c:choose>
                <c:when test="${file.status == 'PROCESSING'}">
                  File đang được phân tích. Vui lòng quay lại sau ít phút.
                </c:when>
                <c:when test="${file.status == 'FAILED'}">
                  Đã có lỗi xảy ra trong quá trình phân tích file.
                </c:when>
                <c:otherwise>
                  File chưa được phân tích hoặc đang chờ xử lý.
                </c:otherwise>
              </c:choose>
            </p>
            <c:if test="${file.status == 'PROCESSING'}">
              <button class="btn btn-primary" onclick="location.reload()">
                🔄 Làm mới trang
              </button>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </body>
</html>
