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
    .page-title{
    font-family:'Space Grotesk',sans-serif;
    font-size:34px;
    font-weight:700;
}

.stats-card{
    border:none;
    border-radius:18px;
    box-shadow:0 10px 25px rgba(0,0,0,.08);
    transition:.3s;
}

.stats-card:hover{
    transform:translateY(-4px);
}

.stats-number{
    font-size:30px;
    font-weight:700;
    font-family:'Space Grotesk',sans-serif;
}

.stats-title{
    font-size:14px;
    color:#6c757d;
    font-weight:600;
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

<div class="container py-5" style="max-width:1200px;">

<div class="mb-4">

<% if("admin".equals(role)){ %>

<h2 class="page-title">
    <i class="bi bi-speedometer2 me-2"></i>
    Complaint Dashboard
</h2>

<p class="text-muted">
    Manage user complaints and update their progress.
</p>

<div class="row g-3 mb-4">

    <div class="col-md-3">
        <div class="card stats-card text-center p-3">
            <div class="stats-title">
            <i class="bi bi-list-task me-1"></i>
              Total Complaints
           </div>
            <div class="stats-number text-dark">
                <%= request.getAttribute("totalComplaints") %>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card stats-card text-center p-3">
            <div class="stats-title">
              <i class="bi bi-hourglass me-1"></i>
              Pending
           </div>
            <div class="stats-number text-warning">
                <%= request.getAttribute("pendingComplaints") %>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card stats-card text-center p-3">
            <div class="stats-title">
            <i class="bi bi-arrow-repeat me-1"></i>
             In Progress
           </div>
            <div class="stats-number text-primary">
                <%= request.getAttribute("inProgressComplaints") %>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card stats-card text-center p-3">
            <div class="stats-title">
              <i class="bi bi-check-circle-fill me-1"></i>
                 Solved
            </div>
            <div class="stats-number text-success">
                <%= request.getAttribute("solvedComplaints") %>
            </div>
        </div>
    </div>

</div>

<% } else { %>

<h2 class="page-title">
    <i class="bi bi-clipboard-check-fill me-2"></i>
    My Complaints
</h2>

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
    <div class="d-flex justify-content-between align-items-start gap-3">
        <div style="width:100%">
            <span class="badge bg-<%= urgencyColor %> me-1"><%= urgency %></span>
            <span class="badge <%= badgeClass %>"><%= status %></span>
            
            <h5 class="fw-bold mt-3 mb-2">
    <%= rs.getString("title") %>
</h5>

<div class="small text-muted mb-2">

    <span class="me-3">
        <i class="bi bi-folder-fill me-1"></i>
        <strong>Category:</strong> <%= category %>
    </span>

    <% if("admin".equals(role)){ %>

    <span>
        <i class="bi bi-person-fill me-1"></i>
        <strong>User:</strong> <%= createdBy %>
    </span>

    <% } %>

</div>
            <p class="mt-2 mb-2 text-secondary lh-lg"><%= rs.getString("description") %></p>

            <!-- ADMIN: Show remark input box -->
            <% if("admin".equals(role)){ %>
            <div class="admin-remark-area">
                <label class="form-label fw-semibold small mb-1">
                    <i class="bi bi-pencil-square me-1"></i>
                        Admin Update
                 </label>
                <form action="${pageContext.request.contextPath}/UpdateRemarkServlet" method="post" class="d-flex gap-2">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="text" name="remark" class="form-control form-control-sm"
                           placeholder="Write update for user..."
                           value="<%= remark != null ? remark : "" %>">
                    <button type="submit" class="btn btn-sm btn-primary" style="white-space:nowrap">
                     <i class="bi bi-save me-1"></i> Save
                  </button>
                </form>
            </div>
            <% } %>

            <!-- USER: Show remark only if status is In Progress or Solved -->
            <% if(!"admin".equals(role) && remark != null && !remark.trim().isEmpty()){ %>
                <% if("Solved".equals(status)){ %>
                <div class="remark-box">
                    <strong>
                    <i class="bi bi-chat-left-text-fill me-1"></i>
                   Admin Response:
                   </strong> 
                <%= remark %>
                </div>
                <% } else if("In Progress".equals(status)){ %>
                <div class="remark-box-progress">
                    <strong>
                     <i class="bi bi-chat-dots-fill me-1"></i>
                      Admin Update:
                  </strong> <%= remark %>
                </div>
                <% } %>
            <% } %>

        </div>
      <span class="badge bg-dark px-3 py-2 fw-semibold align-self-start">
      CMP-<%= String.format("%04d", rs.getInt("id")) %>
    </span>
    </div>

<div class="d-flex gap-2 mt-3 flex-wrap">
        <% if("admin".equals(role)){ %>
        
        <a href="${pageContext.request.contextPath}/UpdateStatusServlet?id=<%= rs.getInt("id") %>&status=In Progress"
          class="btn btn-sm btn-info text-white">
             <i class="bi bi-hourglass-split me-1"></i>
            In Progress
        </a>

    <a href="${pageContext.request.contextPath}/UpdateStatusServlet?id=<%= rs.getInt("id") %>&status=Solved"
       class="btn btn-sm btn-success">
    <i class="bi bi-check-circle-fill me-1"></i>
    Solved
</a>
        <% } %>
        <a href="${pageContext.request.contextPath}/DeleteComplaintServlet?id=<%= rs.getInt("id") %>"
   class="btn btn-sm btn-danger"
   onclick="return confirm('Delete this complaint?')">
    <i class="bi bi-trash-fill me-1"></i>
    Delete
     </a>
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

<footer class="text-center py-4 mt-5 text-muted border-top">
    <small>
        Complaint Management System • Campus Maintenance & Facility Support
        <br>
        © 2026 Presidency University
    </small>
</footer>
</body>
</html>