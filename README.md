# Complaint Management System - Java Full Stack

A web-based Complaint Management System built using Java JSP, Servlets and MySQL.

## Technologies Used
- Java JSP & Servlets
- MySQL Database
- JDBC for database connectivity
- Bootstrap 5 for UI
- Apache Tomcat Server
- Eclipse IDE

## Features
- User Login & Admin Login
- User can submit complaints with category and urgency
- User can view their own complaints
- User can delete their complaints
- Admin can view all complaints
- Admin can write remarks for each complaint
- Admin can update status (Pending / In Progress / Solved)
- Session Management for role based access
- Responsive UI with Bootstrap

## Database Tables
- login (username, password, role)
- complaints (id, title, description, category, urgency, status, created_by, admin_remark)

## How to Run
1. Import project in Eclipse
2. Setup MySQL database complaint_db
3. Run on Apache Tomcat Server
4. Open browser: http://localhost:8181/ComplaintSystem1/jsp/login.jsp

## Login Credentials
- Admin: username=admin
- User: username=user1
