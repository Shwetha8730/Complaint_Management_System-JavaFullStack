<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Complaint System - Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .login-wrapper {
        background: white;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        width: 100%;
        max-width: 420px;
        padding: 45px 40px;
    }

    .logo-area {
        text-align: center;
        margin-bottom: 25px;
    }

    .logo-icon {
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        width: 70px;
        height: 70px;
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        font-size: 32px;
    }

    .logo-area h2 {
        font-weight: 700;
        color: #1e1b4b;
        font-size: 24px;
    }

    .logo-area p {
        color: #6b7280;
        font-size: 14px;
        margin-top: 4px;
    }

    .form-label {
        font-weight: 600;
        color: #374151;
        font-size: 14px;
    }

    .form-control {
        border-radius: 10px;
        padding: 12px 15px;
        border: 1.5px solid #e5e7eb;
        font-size: 15px;
        transition: all 0.3s;
    }

    .form-control:focus {
        border-color: #4f46e5;
        box-shadow: 0 0 0 3px rgba(79,70,229,0.15);
    }

    .btn-login {
        width: 100%;
        padding: 13px;
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        border: none;
        border-radius: 10px;
        color: white;
        font-size: 16px;
        font-weight: 600;
        margin-top: 10px;
        cursor: pointer;
        transition: opacity 0.3s;
    }

    .btn-login:hover {
        opacity: 0.9;
        color: white;
    }

    .error-box {
        background: #fef2f2;
        border: 1px solid #fecaca;
        color: #dc2626;
        border-radius: 10px;
        padding: 10px 15px;
        font-size: 14px;
        margin-bottom: 15px;
        text-align: center;
    }

    .footer-text {
        text-align: center;
        margin-top: 20px;
        color: #9ca3af;
        font-size: 13px;
    }
</style>
</head>
<body>

<div class="login-wrapper">

    <div class="logo-area">
        <div class="logo-icon">🎫</div>
        <h2>Complaint System</h2>
        <p>Sign in to your account</p>
    </div>

    <% if(request.getParameter("error") != null){ %>
    <div class="error-box">
        Invalid username or password. Please try again.
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/LoginServlet" method="post">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username"
                   placeholder="Enter your username"
                   class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password"
                   placeholder="Enter your password"
                   class="form-control" required>
        </div>

        <button class="btn btn-login">Login</button>

    </form>

    <div class="footer-text">
        Presidency University &copy; 2026
    </div>

</div>

</body>
</html>