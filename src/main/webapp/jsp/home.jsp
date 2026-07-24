<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Complaint System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Space+Grotesk:wght@500;700&display=swap" rel="stylesheet">
<style>
:root{
    --primary:#23313A;
    --secondary:#2F4858;
    --light:#F7F9FB;
    --border:#E4E8EE;
    --text:#2D3748;
}

body{
    background:var(--light);
    font-family:'Inter',sans-serif;
    color:var(--text);
}

.navbar{
    background:linear-gradient(135deg,#23313A,#2F4858);
    padding:12px 28px;
    box-shadow:0 6px 20px rgba(0,0,0,.08);
}

.navbar-brand{
    font-size:28px;
    font-weight:700;
}

.navbar .btn{
    padding:8px 18px;
    font-weight:600;
}

.dashboard-title{
    font-size:34px;
    font-weight:700;
    margin-bottom:10px;
}

.dashboard-subtitle{
    color:#6c757d;
    margin-bottom:35px;
}

.info-card,
.form-card{
    background:#fff;
    border:none;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,.08);
}

.info-card{
    padding:35px;
    height:100%;
}

.form-card{
    padding:35px;
}

.info-icon{
    width:70px;
    height:70px;
    border-radius:16px;
    background:linear-gradient(135deg,#23313A,#2F4858);
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
    margin-bottom:20px;
}

.feature{
    margin-top:18px;
    padding:14px;
    border-left:5px solid var(--primary);
    background:#F8FAFC;
    border-radius:12px;
    transition:.25s;
}

.feature:hover{
    transform:translateX(4px);
    background:#EEF3F8;
}

.form-label{
    font-weight:600;
}

.form-control,
.form-select{
    border-radius:12px;
    padding:12px;
}

.btn-submit{
    width:100%;
    background:var(--primary);
    color:#fff;
    border:none;
    border-radius:12px;
    padding:13px;
    font-weight:600;
    transition:.3s;
}

.btn-submit:hover{
    background:#1d2930;
    transform:translateY(-2px);
}

.btn-light{
    border-radius:10px;
}

.btn-outline-light{
    border-radius:10px;
}

@media(max-width:768px){

.dashboard-title{
font-size:28px;
}

.info-card{
margin-bottom:25px;
   }
}

.info-card,
.form-card{
    transition: all 0.3s ease;
}

.info-card:hover,
.form-card:hover{
    transform: translateY(-5px);
    box-shadow: 0 18px 35px rgba(0,0,0,.10);
}
.navbar-brand,
.dashboard-title,
.form-card h4,
.info-card h4{
    font-family:'Space Grotesk', sans-serif;
}

.portal-badge{
    background:#fff;
    color:#23313A;
    font-size:11px;
    font-weight:700;
    letter-spacing:1px;
    padding:5px 10px;
    border-radius:16px;
    text-transform:uppercase;
}

footer{
    font-size:14px;
}

</style>
</head>
<body>

<%
    String loggedUser = (String) session.getAttribute("username");
    if(loggedUser == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>

<nav class="navbar navbar-dark px-4 py-3 d-flex flex-wrap justify-content-between align-items-center">
  <div class="d-flex align-items-center gap-3">

    <span class="navbar-brand mb-0 d-flex align-items-center gap-2">
        <i class="bi bi-buildings-fill fs-3"></i>
        Complaint Management System
    </span>

    <span class="portal-badge">
        USER PORTAL
    </span>

</div>
    <div class="d-flex flex-wrap gap-2 align-items-center mt-2 mt-md-0">
        <span class="text-white-50 small">Hello, <%= loggedUser %></span>
        <a href="${pageContext.request.contextPath}/ViewComplaintServlet"
           class="btn btn-light btn-sm">View My Complaints</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet"
           class="btn btn-outline-light btn-sm">Logout</a>
    </div>
</nav>

<div class="container py-5" style="max-width:1200px;">

    <div class="mb-5">
        <h2 class="dashboard-title">
            Welcome, <%= loggedUser %> 
        </h2>

        <p class="dashboard-subtitle">
            Track your complaints or raise a new request below.
        </p>
 </div>
    <div class="row g-4">

        <!-- Left Side -->

        <div class="col-lg-4">

            <div class="info-card">

                <div class="info-icon">
                    <i class="bi bi-shield-check"></i>
                </div>

                <h4 class="fw-bold mb-3">
                   <i class="bi bi-clipboard-check-fill me-2"></i>
                     My Complaints
                </h4>

                <p class="text-muted">
                    View your complaint history, monitor current requests, and submit new complaints whenever required.
                </p>

                <div class="feature">
                    <strong><i class="bi bi-lightning-charge-fill"></i> Easy Submission</strong><br>
                    Submit complaints in less than a minute.
                </div>

                <div class="feature">
                    <strong><i class="bi bi-clock-history"></i> Real-time Tracking</strong><br>
                    Monitor complaint progress from your dashboard.
                </div>

                <div class="feature">
                    <strong><i class="bi bi-shield-lock-fill"></i> Secure Management</strong><br>
                    Your complaint history is safely maintained.
                </div>

            </div>

        </div>

        <!-- Right Side -->

        <div class="col-lg-8">

            <div class="form-card">

                <h4 class="fw-bold mb-4">
                 <i class="bi bi-pencil-square me-2"></i>
                   Raise New Complaint
                </h4>

                <form action="${pageContext.request.contextPath}/AddComplaintServlet" method="post">

                    <div class="mb-3">

    <label class="form-label"><i class="bi bi-folder-fill me-2"></i>Category</label>

    <select name="category" class="form-select" required>

        <option value="">Select Category</option>
        <option>Internet</option>
        <option>Maintenance</option>
        <option>House Keeping</option>
        <option>Mess</option>
        <option>Other</option>

    </select>

</div>

<div class="mb-3">

    <label class="form-label"><i class="bi bi-pencil-square me-2"></i>Complaint Title</label>

    <input type="text"
           name="title"
           class="form-control"
           placeholder="Enter complaint title"
           required>

</div>

                    <div class="mb-3">

                        <label class="form-label"><i class="bi bi-card-text me-2"></i>Description</label>
                        <textarea
                            name="description"
                            rows="5"
                            class="form-control"
                            placeholder="Provide a detailed description of your issue..."
                            required></textarea>

                    </div>

                    <div class="mb-4">

                        <label class="form-label"><i class="bi bi-exclamation-triangle-fill me-2"></i>Urgency</label>
                        <div class="d-flex flex-wrap gap-2">

                            <input type="radio" class="btn-check"
                                   name="urgency"
                                   id="basic"
                                   value="Basic"
                                   checked>

                            <label class="btn btn-outline-secondary" for="basic">
                                Basic
                            </label>

                            <input type="radio" class="btn-check"
                                   name="urgency"
                                   id="medium"
                                   value="Medium">

                            <label class="btn btn-outline-warning" for="medium">
                                Medium
                            </label>

                            <input type="radio" class="btn-check"
                                   name="urgency"
                                   id="critical"
                                   value="Critical">

                            <label class="btn btn-outline-danger" for="critical">
                                Critical
                            </label>

                        </div>

                    </div>

                    <button class="btn btn-submit">
                        <i class="bi bi-send-fill"></i>
                        Submit Complaint
                    </button>

                </form>

            </div>

        </div>

    </div>

</div>
<footer class="text-center py-4 mt-5 text-muted border-top">
    <small>
        Complaint Management System • Campus Maintenance & Facility Support
        <br>
        © 2026 Presidency University
    </small>
</footer>
</body>
</html>