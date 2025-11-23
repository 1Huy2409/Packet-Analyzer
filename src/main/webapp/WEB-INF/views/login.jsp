<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đăng Nhập - Packet Analyzer</title>
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
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
      }

      /* Light mode subtle background gradient for depth */
      body::before {
        content: "";
        position: absolute;
        width: 800px;
        height: 800px;
        background: radial-gradient(
          circle,
          rgba(37, 99, 235, 0.08) 0%,
          transparent 70%
        );
        border-radius: 50%;
        top: -300px;
        right: -150px;
        pointer-events: none;
        filter: blur(40px);
      }

      body::after {
        content: "";
        position: absolute;
        width: 600px;
        height: 600px;
        background: radial-gradient(
          circle,
          rgba(59, 130, 246, 0.05) 0%,
          transparent 70%
        );
        border-radius: 50%;
        bottom: -200px;
        left: -100px;
        pointer-events: none;
        filter: blur(40px);
      }

      /* Updated container to white with light shadow */
      .container {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        width: 100%;
        max-width: 420px;
        animation: slideUp 0.7s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
        z-index: 1;
      }

      @keyframes slideUp {
        from {
          opacity: 0;
          transform: translateY(50px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      /* Light header background */
      .header {
        background: linear-gradient(135deg, #ffffff 0%, #f9fafb 100%);
        padding: 60px 30px;
        text-align: center;
        border-bottom: 1px solid #e5e7eb;
        position: relative;
      }

      .header::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 1px;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(229, 231, 235, 0.5),
          transparent
        );
      }

      .header .icon {
        font-size: 48px;
        margin-bottom: 16px;
        display: inline-block;
        animation: float 3s ease-in-out infinite;
      }

      @keyframes float {
        0%,
        100% {
          transform: translateY(0px);
        }
        50% {
          transform: translateY(-8px);
        }
      }

      /* Dark text for light mode */
      .header h1 {
        font-size: 32px;
        margin-bottom: 8px;
        color: #1f2937;
        font-weight: 700;
        letter-spacing: -0.7px;
      }

      /* Gray subtitle text */
      .header p {
        font-size: 14px;
        color: #6b7280;
        font-weight: 400;
        letter-spacing: 0.2px;
      }

      .form-container {
        padding: 45px 30px;
      }

      /* Light mode alert styling */
      .alert {
        padding: 14px 16px;
        border-radius: 10px;
        margin-bottom: 24px;
        font-size: 13px;
        border: 1px solid transparent;
        animation: alertSlideIn 0.4s ease-out;
      }

      @keyframes alertSlideIn {
        from {
          opacity: 0;
          transform: translateY(-10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .alert-error {
        background-color: #fee2e2;
        border-color: #fecaca;
        color: #991b1b;
      }

      .alert-success {
        background-color: #dcfce7;
        border-color: #bbf7d0;
        color: #166534;
      }

      /* Enhanced form group spacing and styling */
      .form-group {
        margin-bottom: 28px;
      }

      /* Dark labels for light mode */
      .form-group label {
        display: block;
        margin-bottom: 10px;
        color: #374151;
        font-weight: 600;
        font-size: 14px;
        letter-spacing: 0.4px;
      }

      /* Light input styling with light blue background */
      .form-group input {
        width: 100%;
        padding: 13px 16px;
        border: 1.5px solid #d1d5db;
        background: #f9fafb;
        border-radius: 10px;
        font-size: 14px;
        color: #1f2937;
        transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        font-family: inherit;
        font-weight: 500;
      }

      .form-group input::placeholder {
        color: #9ca3af;
        font-weight: 400;
      }

      /* Blue focus state for light inputs */
      .form-group input:focus {
        outline: none;
        border-color: #2563eb;
        background: #ffffff;
        box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15);
        transform: translateY(-1px);
      }

      .form-group input:hover:not(:focus) {
        border-color: #c7d2e0;
      }

      /* Blue button for light mode */
      .btn {
        width: 100%;
        padding: 13px 16px;
        background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        letter-spacing: 0.4px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(37, 99, 235, 0.2);
      }

      .btn::before {
        content: "";
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
      }

      .btn:hover::before {
        width: 300px;
        height: 300px;
      }

      .btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(37, 99, 235, 0.3);
        background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%);
      }

      .btn:active {
        transform: translateY(-1px);
      }

      /* Light divider styling */
      .divider {
        text-align: center;
        margin: 32px 0;
        position: relative;
      }

      .divider::before {
        content: "";
        position: absolute;
        left: 0;
        top: 50%;
        width: 100%;
        height: 1px;
        background: #e5e7eb;
      }

      /* Light divider text */
      .divider span {
        background: #ffffff;
        padding: 0 14px;
        position: relative;
        color: #9ca3af;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.3px;
      }

      /* Light register link styling */
      .register-link {
        text-align: center;
        margin-top: 24px;
        color: #6b7280;
        font-size: 14px;
        font-weight: 500;
      }

      .register-link a {
        color: #2563eb;
        text-decoration: none;
        font-weight: 700;
        transition: all 0.3s ease;
        position: relative;
        letter-spacing: 0.2px;
      }

      .register-link a::after {
        content: "";
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 0;
        height: 2px;
        background: #2563eb;
        transition: width 0.3s ease;
      }

      .register-link a:hover {
        color: #1d4ed8;
      }

      .register-link a:hover::after {
        width: 100%;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <div class="icon">🔐</div>
        <h1>Đăng Nhập</h1>
        <p>Network Packet Analyzer System</p>
      </div>

      <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
          <%= request.getAttribute("error") %>
        </div>
        <% } %> <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
          <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
          <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input
              type="text"
              id="username"
              name="username"
              placeholder="Nhập tên đăng nhập"
              required
              autofocus
            />
          </div>

          <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Nhập mật khẩu"
              required
            />
          </div>

          <button type="submit" class="btn">Đăng Nhập</button>
        </form>

        <div class="divider">
          <span>hoặc</span>
        </div>

        <div class="register-link">
          Chưa có tài khoản?
          <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
        </div>
      </div>
    </div>
  </body>
</html>
