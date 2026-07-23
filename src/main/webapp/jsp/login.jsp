<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Complaint System - Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="login-container">

    <div class="login-card">

        <div class="logo-area">

            <div class="logo-icon">
                <i class="bi bi-buildings-fill"></i>
            </div>

            <h2>Complaint Management System</h2>

            <p>Campus Maintenance & Facility Support</p>

        </div>

        <% if(request.getParameter("error") != null){ %>

        <div class="error-box">
            Invalid username or password.
        </div>

        <% } %>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">

            <div class="mb-3">
                <label class="form-label">Username</label>

                <input
                    type="text"
                    name="username"
                    class="form-control"
                    placeholder="Enter username"
                    required>
            </div>

            <div class="mb-4">
                <label class="form-label">Password</label>

                <input
                    type="password"
                    name="password"
                    class="form-control"
                    placeholder="Enter password"
                    required>
            </div>

            <div class="mt-2">
               <button type="submit" class="btn-login">
                 Sign In
              </button>
           </div>

        </form>

        <div class="footer-text">
            Presidency University © 2026
        </div>

    </div>

</div>

</body>
</html>