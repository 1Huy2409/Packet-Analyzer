<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Packet Analyzer</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: #0f1419;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        /* Professional dark mode background with subtle gradient */
        body::before {
            content: '';
            position: absolute;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%);
            border-radius: 50%;
            top: -200px;
            right: -100px;
            pointer-events: none;
        }

        .container {
            background: #1a1f2e;
            border: 1px solid #2a3142;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            width: 100%;
            max-width: 480px;
            animation: slideUp 0.6s ease-out;
            position: relative;
            z-index: 1;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            background: linear-gradient(135deg, #1a1f2e 0%, #242d3f 100%);
            padding: 50px 30px;
            text-align: center;
            border-bottom: 1px solid #2a3142;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 8px;
            color: #ffffff;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        .header p {
            font-size: 14px;
            color: #9ca3af;
            font-weight: 400;
        }

        .form-container {
            padding: 40px 30px;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 13px;
            border: 1px solid transparent;
        }

        .alert-error {
            background-color: rgba(239, 68, 68, 0.1);
            border-color: rgba(239, 68, 68, 0.3);
            color: #fca5a5;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #e5e7eb;
            font-weight: 500;
            font-size: 14px;
            letter-spacing: 0.3px;
        }

        .form-group input {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #3f4655;
            background: #0f1419;
            border-radius: 8px;
            font-size: 14px;
            color: #e5e7eb;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input::placeholder {
            color: #6b7280;
        }

        .form-group input:focus {
            outline: none;
            border-color: #3b82f6;
            background: #0f1419;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-group small {
            display: block;
            margin-top: 6px;
            color: #6b7280;
            font-size: 12px;
        }

        .btn {
            width: 100%;
            padding: 11px 16px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 0.3px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(59, 130, 246, 0.35);
        }

        .btn:active {
            transform: translateY(0);
        }

        .divider {
            text-align: center;
            margin: 28px 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #2a3142;
        }

        .divider span {
            background: #1a1f2e;
            padding: 0 12px;
            position: relative;
            color: #6b7280;
            font-size: 13px;
            font-weight: 500;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
            font-size: 14px;
        }

        .login-link a:hover {
            color: #60a5fa;
        }

        .icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .password-strength {
            height: 3px;
            background: #2a3142;
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }

        .strength-weak {
            width: 33%;
            background: #ef4444;
        }

        .strength-medium {
            width: 66%;
            background: #f59e0b;
        }

        .strength-strong {
            width: 100%;
            background: #10b981;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="icon">📝</div>
            <h1>Đăng Ký</h1>
            <p>Tạo tài khoản mới</p>
        </div>
        
        <div class="form-container">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Tên đăng nhập *</label>
                    <input type="text" id="username" name="username" 
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           placeholder="Nhập username" required autofocus>
                    <small>Tên đăng nhập phải là duy nhất</small>
                </div>

                <div class="form-group">
                    <label for="email">Email *</label>
                    <input type="email" id="email" name="email" 
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                           placeholder="name@example.com" required>
                    <small>Dùng để khôi phục tài khoản</small>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu *</label>
                    <input type="password" id="password" name="password" 
                           placeholder="Tối thiểu 6 ký tự" required
                           onkeyup="checkPasswordStrength()">
                    <div class="password-strength">
                        <div id="strengthBar" class="password-strength-bar"></div>
                    </div>
                    <small id="strengthText" style="color: #6b7280;">Mật khẩu phải có ít nhất 6 ký tự</small>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           placeholder="Nhập lại mật khẩu" required>
                </div>

                <button type="submit" class="btn">Tạo Tài Khoản</button>
            </form>

            <div class="divider">
                <span>hoặc</span>
            </div>

            <div class="login-link">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </div>
        </div>
    </div>

    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            strengthBar.className = 'password-strength-bar';
            
            if (password.length < 6) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Mật khẩu quá yếu';
                strengthText.style.color = '#ef4444';
            } else if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Mật khẩu yếu';
                strengthText.style.color = '#ef4444';
            } else if (strength <= 3) {
                strengthBar.classList.add('strength-medium');
                strengthText.textContent = 'Mật khẩu trung bình';
                strengthText.style.color = '#f59e0b';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthText.textContent = 'Mật khẩu mạnh';
                strengthText.style.color = '#10b981';
            }
        }
        
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Mật khẩu không khớp!');
                return false;
            }
            
            if (password.length < 6) {
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
