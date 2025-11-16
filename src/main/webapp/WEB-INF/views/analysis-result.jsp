<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả phân tích - ${file.fileName}</title>
    <!-- vscode-css-languageservice-custom-disable -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            background: white;
            padding: 25px 35px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #333;
            font-size: 26px;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        /* File info card */
        .file-info-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .file-info-card h2 {
            color: #333;
            font-size: 18px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .file-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
        }

        .file-detail-item {
            display: flex;
            flex-direction: column;
        }

        .file-detail-label {
            font-size: 13px;
            color: #666;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .file-detail-value {
            font-size: 15px;
            color: #333;
            font-weight: 600;
        }

        /* Status */
        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-processing {
            background: #fff3cd;
            color: #856404;
        }

        .status-done {
            background: #d4edda;
            color: #155724;
        }

        .status-failed {
            background: #f8d7da;
            color: #721c24;
        }

        /* Stats grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .stat-icon {
            font-size: 36px;
            margin-bottom: 12px;
        }

        .stat-label {
            font-size: 13px;
            color: #666;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .stat-value {
            font-size: 28px;
            color: #333;
            font-weight: 700;
        }

        .stat-unit {
            font-size: 14px;
            color: #999;
            margin-left: 5px;
        }

        /* Detailed stats */
        .detailed-stats {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }

        .detailed-stats h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 25px;
            padding-bottom: 12px;
            border-bottom: 2px solid #f0f0f0;
        }

        .stats-table {
            width: 100%;
            border-collapse: collapse;
        }

        .stats-table tr {
            border-bottom: 1px solid #f0f0f0;
        }

        .stats-table tr:last-child {
            border-bottom: none;
        }

        .stats-table td {
            padding: 15px 10px;
        }

        .stats-table td:first-child {
            color: #666;
            font-weight: 500;
            width: 40%;
        }

        .stats-table td:last-child {
            color: #333;
            font-weight: 600;
            text-align: right;
        }

        /* Protocol chart */
        .protocol-chart {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .protocol-chart h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 25px;
            padding-bottom: 12px;
            border-bottom: 2px solid #f0f0f0;
        }

        .protocol-item {
            margin-bottom: 20px;
        }

        .protocol-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .protocol-name {
            font-weight: 600;
            color: #333;
        }

        .protocol-count {
            color: #666;
            font-weight: 500;
        }

        .protocol-bar {
            height: 30px;
            background: #f0f0f0;
            border-radius: 15px;
            overflow: hidden;
            position: relative;
        }

        .protocol-fill {
            height: 100%;
            border-radius: 15px;
            transition: width 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 15px;
            color: white;
            font-weight: 600;
            font-size: 13px;
        }

        .protocol-tcp {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .protocol-udp {
            background: linear-gradient(90deg, #f093fb 0%, #f5576c 100%);
        }

        .protocol-other {
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
        }

        /* No result */
        .no-result {
            background: white;
            padding: 60px 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .no-result-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .no-result h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .no-result p {
            color: #666;
            font-size: 15px;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .file-details {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/upload" class="btn btn-secondary">
                    ← Quay lại
                </a>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                    🏠 Dashboard
                </a>
            </div>
        </div>

        <!-- File Info -->
        <div class="file-info-card">
            <h2>📁 Thông tin file</h2>
            <div class="file-details">
                <div class="file-detail-item">
                    <span class="file-detail-label">Tên file</span>
                    <span class="file-detail-value">${file.fileName}</span>
                </div>
                <div class="file-detail-item">
                    <span class="file-detail-label">Thời gian upload</span>
                    <span class="file-detail-value">${file.uploadTime}</span>
                </div>
                <div class="file-detail-item">
                    <span class="file-detail-label">Trạng thái</span>
                    <span class="status-badge status-${file.status.toLowerCase()}">${file.status}</span>
                </div>
                <c:if test="${result != null}">
                    <div class="file-detail-item">
                        <span class="file-detail-label">Thời gian xử lý</span>
                        <span class="file-detail-value">${result.processingTimeMs} ms</span>
                    </div>
                </c:if>
            </div>
        </div>

        <c:choose>
            <c:when test="${result != null}">
                <!-- Stats Grid -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">📦</div>
                        <div class="stat-label">Tổng số flows</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${result.totalFlows}" type="number"/>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">⬆️</div>
                        <div class="stat-label">Tổng bytes gửi</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${result.totalBytesSent}" type="number"/>
                            <span class="stat-unit">bytes</span>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">⬇️</div>
                        <div class="stat-label">Tổng bytes nhận</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${result.totalBytesReceived}" type="number"/>
                            <span class="stat-unit">bytes</span>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">⚡</div>
                        <div class="stat-label">Throughput gửi TB</div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${result.avgThroughputSent}" maxFractionDigits="2"/>
                            <span class="stat-unit">Bps</span>
                        </div>
                    </div>
                </div>

                <!-- Detailed Stats -->
                <div class="detailed-stats">
                    <h2>📈 Thống kê chi tiết</h2>
                    <table class="stats-table">
                        <tr>
                            <td>Throughput nhận trung bình</td>
                            <td><fmt:formatNumber value="${result.avgThroughputReceive}" maxFractionDigits="2"/> Bps</td>
                        </tr>
                        <tr>
                            <td>RTT trung bình</td>
                            <td><fmt:formatNumber value="${result.avgRtt}" maxFractionDigits="2"/> ms</td>
                        </tr>
                        <tr>
                            <td>Thời gian flow trung bình</td>
                            <td><fmt:formatNumber value="${result.avgFlowDuration}" maxFractionDigits="2"/> s</td>
                        </tr>
                        <tr>
                            <td>Kích thước gói trung bình</td>
                            <td><fmt:formatNumber value="${result.avgPacketSizeMean}" maxFractionDigits="2"/> bytes</td>
                        </tr>
                    </table>
                </div>

                <!-- Protocol Distribution -->
                <div class="protocol-chart">
                    <h2>🔌 Phân bố Protocol</h2>
                    
                    <c:set var="totalProtocol" value="${result.tcpFlows + result.udpFlows + result.otherFlows}"/>
                    
                    <c:choose>
                        <c:when test="${totalProtocol > 0}">
                            <c:set var="tcpPercent" value="${result.tcpFlows * 100.0 / totalProtocol}"/>
                            <div class="protocol-item">
                                <div class="protocol-header">
                                    <span class="protocol-name">TCP</span>
                                    <span class="protocol-count">${result.tcpFlows} flows</span>
                                </div>
                                <div class="protocol-bar">
                                    <div class="protocol-fill protocol-tcp" style="width: ${tcpPercent}%">
                                        <fmt:formatNumber value="${tcpPercent}" maxFractionDigits="1"/>%
                                    </div>
                                </div>
                            </div>

                            <c:set var="udpPercent" value="${result.udpFlows * 100.0 / totalProtocol}"/>
                            <div class="protocol-item">
                                <div class="protocol-header">
                                    <span class="protocol-name">UDP</span>
                                    <span class="protocol-count">${result.udpFlows} flows</span>
                                </div>
                                <div class="protocol-bar">
                                    <div class="protocol-fill protocol-udp" style="width: ${udpPercent}%">
                                        <fmt:formatNumber value="${udpPercent}" maxFractionDigits="1"/>%
                                    </div>
                                </div>
                            </div>

                            <c:if test="${result.otherFlows > 0}">
                                <c:set var="otherPercent" value="${result.otherFlows * 100.0 / totalProtocol}"/>
                                <div class="protocol-item">
                                    <div class="protocol-header">
                                        <span class="protocol-name">Khác</span>
                                        <span class="protocol-count">${result.otherFlows} flows</span>
                                    </div>
                                    <div class="protocol-bar">
                                        <div class="protocol-fill protocol-other" style="width: ${otherPercent}%">
                                            <fmt:formatNumber value="${otherPercent}" maxFractionDigits="1"/>%
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; color: #999; padding: 30px;">Không có dữ liệu protocol</p>
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
                            <c:when test="${file.status == 'PROCESSING'}">Đang xử lý...</c:when>
                            <c:when test="${file.status == 'FAILED'}">Phân tích thất bại</c:when>
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
                        <button class="btn btn-primary" onclick="location.reload()" style="margin-top: 20px;">
                            🔄 Làm mới trang
                        </button>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
