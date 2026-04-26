<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Complaint System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f0f2f5; }
    .navbar { background-color: #4f46e5; }
    .card {
        border-radius: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        border: none;
    }
    .btn-submit {
        background-color: #4f46e5;
        color: white;
        border-radius: 8px;
        padding: 10px 30px;
        border: none;
        font-weight: 600;
        width: 100%;
    }
    .btn-submit:hover { background-color: #4338ca; color: white; }
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

<nav class="navbar navbar-dark px-4 py-3 d-flex justify-content-between">
    <span class="navbar-brand fw-bold fs-4">Complaint System</span>
    <div class="d-flex gap-2 align-items-center">
        <span class="text-white-50 small">Hello, <%= loggedUser %></span>
        <a href="${pageContext.request.contextPath}/ViewComplaintServlet"
           class="btn btn-light btn-sm">View My Complaints</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet"
           class="btn btn-outline-light btn-sm">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4">
                <h5 class="fw-bold mb-3">Raise New Complaint</h5>

                <form action="${pageContext.request.contextPath}/AddComplaintServlet" method="post">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Category</label>
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
                        <label class="form-label fw-semibold">Title</label>
                        <input type="text" name="title" placeholder="Enter complaint title"
                               class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Description</label>
                        <textarea name="description" placeholder="Describe your complaint..."
                                  class="form-control" rows="4" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Urgency</label>
                        <div class="d-flex gap-2">
                            <input type="radio" class="btn-check" name="urgency"
                                   id="basic" value="Basic" checked>
                            <label class="btn btn-outline-secondary" for="basic">Basic</label>

                            <input type="radio" class="btn-check" name="urgency"
                                   id="medium" value="Medium">
                            <label class="btn btn-outline-warning" for="medium">Medium</label>

                            <input type="radio" class="btn-check" name="urgency"
                                   id="critical" value="Critical">
                            <label class="btn btn-outline-danger" for="critical">Critical</label>
                        </div>
                    </div>

                    <button class="btn btn-submit">Submit Complaint</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>