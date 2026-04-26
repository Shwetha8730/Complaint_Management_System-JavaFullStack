<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Complaints</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
    .navbar { background: linear-gradient(135deg, #4f46e5, #7c3aed); }
    .card {
        border-radius: 15px;
        border: none;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        margin-bottom: 15px;
    }
    .badge-pending { background-color: #f59e0b; }
    .badge-progress { background-color: #3b82f6; }
    .badge-solved { background-color: #10b981; }
    .role-tag {
        background: #ede9fe;
        color: #5b21b6;
        font-size: 12px;
        padding: 3px 10px;
        border-radius: 20px;
        font-weight: 600;
    }
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

<nav class="navbar navbar-dark px-4 py-3 d-flex justify-content-between">
    <span class="navbar-brand fw-bold fs-5">
        Complaint System &nbsp;
        <span class="role-tag"><%= "admin".equals(role) ? "Admin" : "User" %></span>
    </span>
    <div class="d-flex gap-2 align-items-center">
        <span class="text-white-50 small">Hello, <%= loggedUser %></span>
        <% if(!"admin".equals(role)){ %>
        <a href="${pageContext.request.contextPath}/jsp/home.jsp"
           class="btn btn-light btn-sm">+ New Complaint</a>
        <% } %>
        <a href="${pageContext.request.contextPath}/LogoutServlet"
           class="btn btn-outline-light btn-sm">Logout</a>
    </div>
</nav>

<div class="container mt-4">

    <% if("admin".equals(role)){ %>
    <div class="alert alert-info py-2">
        <strong>Admin View:</strong> You can see all complaints, write remarks, and update status.
    </div>
    <% } else { %>
    <div class="alert alert-secondary py-2">
        <strong>My Complaints:</strong> Only your submitted complaints are shown here.
    </div>
    <% } %>

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
        <small class="text-muted ms-3">#<%= rs.getInt("id") %></small>
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