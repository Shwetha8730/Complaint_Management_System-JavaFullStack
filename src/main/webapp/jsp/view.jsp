<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Complaints</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Space+Grotesk:wght@500;700&display=swap" rel="stylesheet">
<style>
body{
    background:#f0f2f5;
    font-family:'Inter',sans-serif;
    color:#2D3748;
}
    .navbar{
    background:linear-gradient(135deg,#23313A,#2F4858);
    padding:12px 28px;
    box-shadow:0 6px 20px rgba(0,0,0,.08);
}

.navbar-brand{
    font-family:'Space Grotesk',sans-serif;
    font-size:28px;
    font-weight:700;
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

.navbar .btn{
    padding:8px 18px;
    font-weight:600;
}

.card{
    border:none;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,.08);
    transition:.3s;
    margin-bottom:20px;
}

.card:hover{
    transform:translateY(-5px);
    box-shadow:0 18px 35px rgba(0,0,0,.10);
}

    .badge-pending { background-color: #f59e0b; }
    .badge-progress { background-color: #3b82f6; }
    .badge-solved { background-color: #10b981; }
    .remark-box {
        background: #f0fdf4;
        border-left: 4px solid #10b981;
        border-radius: 8px;
        padding: 10px 15px;
        margin-top: 10px;
        font-size: 14px;
        color: #065f46;
    }
    .remark-box-progress {
        background: #eff6ff;
        border-left: 4px solid #3b82f6;
        border-radius: 8px;
        padding: 10px 15px;
        margin-top: 10px;
        font-size: 14px;
        color: #1e40af;
    }
    .admin-remark-area {
        background: #fafafa;
        border-radius: 10px;
        padding: 12px;
        margin-top: 10px;
        border: 1px solid #e5e7eb;
    }
</style>
</head>
<body>

<%
    String role = (String) session.getAttribute("role");
    String loggedUser = (String) session.getAttribute("username");
    if(role == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>

<nav class="navbar navbar-dark d-flex justify-content-between align-items-center">

    <div class="d-flex align-items-center gap-3">

        <span class="navbar-brand mb-0 d-flex align-items-center gap-2">
            <i class="bi bi-buildings-fill fs-3"></i>
            Complaint Management System
        </span>

        <span class="portal-badge">
            <%= "admin".equals(role) ? "ADMIN PORTAL" : "USER PORTAL" %>
        </span>

    </div>

    <div class="d-flex gap-2 align-items-center">

        <span class="text-white-50 small">
            Hello, <%= loggedUser %>
        </span>

        <% if(!"admin".equals(role)){ %>
        <a href="${pageContext.request.contextPath}/jsp/home.jsp"
           class="btn btn-light btn-sm">
            + New Complaint
        </a>
        <% } %>

        <a href="${pageContext.request.contextPath}/LogoutServlet"
           class="btn btn-outline-light btn-sm">
            Logout
        </a>

    </div>

</nav>

<div class="container mt-4">

   <div class="mb-4">

<% if("admin".equals(role)){ %>

<h2 class="fw-bold">Complaint Dashboard</h2>

<p class="text-muted">
    Manage user complaints and update their progress.
</p>

<% } else { %>

<h2 class="fw-bold">My Complaints</h2>

<p class="text-muted">
    Track your submitted complaints and monitor their current status.
</p>

<% } %>

</div>
<%
ResultSet rs = (ResultSet) request.getAttribute("data");
boolean hasComplaints = false;
while(rs.next()){
    hasComplaints = true;
    String status = rs.getString("status");
    String urgency = rs.getString("urgency") != null ? rs.getString("urgency") : "Basic";
    String category = rs.getString("category") != null ? rs.getString("category") : "General";
    String createdBy = rs.getString("created_by");
    String remark = rs.getString("admin_remark");

    String badgeClass = "badge-pending";
    if("In Progress".equals(status)) badgeClass = "badge-progress";
    if("Solved".equals(status)) badgeClass = "badge-solved";

    String urgencyColor = "secondary";
    if("Medium".equals(urgency)) urgencyColor = "warning";
    if("Critical".equals(urgency)) urgencyColor = "danger";
%>

<div class="card p-3">
    <div class="d-flex justify-content-between align-items-start">
        <div style="width:100%">
            <span class="badge bg-<%= urgencyColor %> me-1"><%= urgency %></span>
            <span class="badge <%= badgeClass %>"><%= status %></span>
            <% if("admin".equals(role)){ %>
            <span class="text-muted small ms-2">by <%= createdBy %></span>
            <% } %>

            <h6 class="mt-2 fw-bold mb-1"><%= rs.getString("title") %></h6>
            <small class="text-muted">Category: <%= category %></small>
            <p class="mt-1 mb-2 text-secondary"><%= rs.getString("description") %></p>

            <!-- ADMIN: Show remark input box -->
            <% if("admin".equals(role)){ %>
            <div class="admin-remark-area">
                <label class="form-label fw-semibold small mb-1">Admin Remark / Update for User:</label>
                <form action="${pageContext.request.contextPath}/UpdateRemarkServlet" method="post" class="d-flex gap-2">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="text" name="remark" class="form-control form-control-sm"
                           placeholder="Write update for user..."
                           value="<%= remark != null ? remark : "" %>">
                    <button type="submit" class="btn btn-sm btn-primary" style="white-space:nowrap">Save Remark</button>
                </form>
            </div>
            <% } %>

            <!-- USER: Show remark only if status is In Progress or Solved -->
            <% if(!"admin".equals(role) && remark != null && !remark.trim().isEmpty()){ %>
                <% if("Solved".equals(status)){ %>
                <div class="remark-box">
                    <strong>Admin Response:</strong> <%= remark %>
                </div>
                <% } else if("In Progress".equals(status)){ %>
                <div class="remark-box-progress">
                    <strong>Admin Update:</strong> <%= remark %>
                </div>
                <% } %>
            <% } %>

        </div>
       <span class="badge bg-dark ms-3 px-3 py-2">
            CMP-<%= String.format("%04d", rs.getInt("id")) %>
      </span>>
    </div>

    <div class="d-flex gap-2 mt-2 flex-wrap">
        <% if("admin".equals(role)){ %>
        <a href="${pageContext.request.contextPath}/UpdateStatusServlet?id=<%= rs.getInt("id") %>&status=In Progress"
           class="btn btn-sm btn-info text-white">In Progress</a>
        <a href="${pageContext.request.contextPath}/UpdateStatusServlet?id=<%= rs.getInt("id") %>&status=Solved"
           class="btn btn-sm btn-success">Solved</a>
        <% } %>
        <a href="${pageContext.request.contextPath}/DeleteComplaintServlet?id=<%= rs.getInt("id") %>"
           class="btn btn-sm btn-danger"
           onclick="return confirm('Delete this complaint?')">Delete</a>
    </div>
</div>

<% }
if(!hasComplaints){ %>
<div class="text-center mt-5 text-muted">
    <h5>No complaints found.</h5>
    <% if(!"admin".equals(role)){ %>
    <a href="${pageContext.request.contextPath}/jsp/home.jsp" class="btn btn-primary mt-2">Submit Your First Complaint</a>
    <% } %>
</div>
<% } %>

</div>
</body>
</html>