<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload File - Packet Analyzer</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
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

        /* Modern upload section with premium feel */
        .upload-section {
            background: white;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 15, 52, 0.08);
            margin-bottom: 40px;
        }

        .upload-label {
            display: block;
            color: #000f34;
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: -0.3px;
        }

        .upload-area {
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            padding: 80px 40px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            background: linear-gradient(135deg, #f8f9fb 0%, #f5f7fa 100%);
            position: relative;
            overflow: hidden;
        }

        .upload-area::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at center, rgba(30, 64, 175, 0.05) 0%, transparent 70%);
            pointer-events: none;
        }

        .upload-area:hover {
            background: linear-gradient(135deg, #f0f7ff 0%, #e8eef8 100%);
            border-color: #1e40af;
            box-shadow: 0 8px 24px rgba(30, 64, 175, 0.1);
        }

        .upload-area.drag-over {
            background: linear-gradient(135deg, #dbeafe 0%, #eff6ff 100%);
            border-color: #1e40af;
            box-shadow: 0 12px 32px rgba(30, 64, 175, 0.15);
            transform: scale(1.02);
        }

        .upload-content {
            position: relative;
            z-index: 1;
        }

        .upload-icon {
            font-size: 72px;
            margin-bottom: 24px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .upload-text {
            font-size: 20px;
            color: #000f34;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .upload-hint {
            font-size: 14px;
            color: #667177;
            line-height: 1.6;
        }

        #fileInput {
            display: none;
        }

        .selected-file {
            margin-top: 24px;
            padding: 20px;
            background: linear-gradient(135deg, #dbeafe 0%, #f0f7ff 100%);
            border: 1px solid #93c5fd;
            border-radius: 10px;
            display: none;
        }

        .selected-file.show {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .file-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .file-details {
            flex: 1;
        }

        .file-name {
            font-weight: 600;
            color: #000f34;
            margin-bottom: 4px;
        }

        .file-size {
            color: #667177;
            font-size: 13px;
        }

        .upload-btn {
            margin-top: 24px;
            width: 100%;
            padding: 16px;
            font-size: 16px;
            font-weight: 600;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideDown 0.3s ease;
        }

        .alert-success {
            background: linear-gradient(135deg, #dcfce7 0%, #d1fae5 100%);
            border: 1px solid #86efac;
            color: #166534;
        }

        .alert-error {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            border: 1px solid #fca5a5;
            color: #991b1b;
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

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #e5e7eb;
            border-radius: 3px;
            overflow: hidden;
            margin-top: 12px;
            display: none;
        }

        .progress-bar.show {
            display: block;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #1e40af 0%, #3b82f6 100%);
            width: 0%;
            transition: width 0.3s ease;
            border-radius: 3px;
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

            .upload-section {
                padding: 30px 20px;
            }

            .upload-area {
                padding: 60px 20px;
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
            <h1>📦 Upload File</h1>
            <div class="user-info">
                <span>👤 ${sessionScope.username}</span>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">Dashboard</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
            </div>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <span>✓</span>
                <span>${success}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <span>✗</span>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Upload Section -->
        <div class="upload-section">
            <label class="upload-label">Tải lên file</label>
            <form id="uploadForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/upload">
                <div class="upload-area" id="uploadArea">
                    <div class="upload-content">
                        <div class="upload-icon">⬆️</div>
                        <div class="upload-text">Kéo thả file vào đây</div>
                        <div class="upload-hint">hoặc <strong>click để chọn</strong> • Hỗ trợ .pcap, .pcapng, .cap, .log, .txt, .csv (Tối đa 500MB)</div>
                        <input type="file" id="fileInput" name="file" accept=".pcap,.pcapng,.cap,.log,.txt,.csv">
                    </div>
                </div>

                <div class="selected-file" id="selectedFile">
                    <div class="file-info">
                        <div class="file-details">
                            <div class="file-name" id="fileName"></div>
                            <div class="file-size" id="fileSize"></div>
                        </div>
                        <button type="button" class="btn btn-secondary" onclick="clearFile()" style="padding: 8px 16px;">✕ Xóa</button>
                    </div>
                    <div class="progress-bar" id="progressBar">
                        <div class="progress-fill" id="progressFill"></div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary upload-btn" id="uploadBtn" disabled>
                    📤 Upload File
                </button>
            </form>
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
                                    <td>
                                        ${file.uploadTime}
                                    </td>
                                    <td>
                                        <span class="status-badge status-${file.status.toLowerCase()}">
                                            ${file.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/analyze?id=${file.id}" 
                                           class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;">
                                            🔍 Phân tích
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-files">
                        <div style="font-size: 48px; margin-bottom: 16px;">📂</div>
                        <p style="font-size: 16px; color: #667177; font-weight: 500;">Chưa có file nào được upload</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const selectedFile = document.getElementById('selectedFile');
        const fileName = document.getElementById('fileName');
        const fileSize = document.getElementById('fileSize');
        const uploadBtn = document.getElementById('uploadBtn');
        const uploadForm = document.getElementById('uploadForm');
        const progressBar = document.getElementById('progressBar');
        const progressFill = document.getElementById('progressFill');

        // Click to select file
        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });

        // File selected
        fileInput.addEventListener('change', (e) => {
            handleFiles(e.target.files);
        });

        // Drag and drop
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('drag-over');
        });

        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('drag-over');
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('drag-over');
            handleFiles(e.dataTransfer.files);
        });

        function handleFiles(files) {
            if (files.length > 0) {
                const file = files[0];
                fileName.textContent = file.name;
                fileSize.textContent = formatBytes(file.size);
                selectedFile.classList.add('show');
                uploadBtn.disabled = false;
            }
        }

        function clearFile() {
            fileInput.value = '';
            selectedFile.classList.remove('show');
            uploadBtn.disabled = true;
            progressBar.classList.remove('show');
            progressFill.style.width = '0%';
        }

        function formatBytes(bytes) {
            if (bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
        }

        uploadForm.addEventListener('submit', (e) => {
            if (fileInput.files.length > 0) {
                progressBar.classList.add('show');
                uploadBtn.disabled = true;
                uploadBtn.textContent = '⏳ Đang upload...';
                
                let progress = 0;
                const interval = setInterval(() => {
                    progress += 5;
                    progressFill.style.width = progress + '%';
                    if (progress >= 95) {
                        clearInterval(interval);
                    }
                }, 100);
            }
        });
    </script>
</body>
</html>
