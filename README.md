# Complaint Management System - Java Full Stack

A web-based complaint management system where students can raise 
complaints online and the admin can track and resolve them efficiently.

## Technologies Used
- Java JSP & Servlets
- MySQL with JDBC
- Bootstrap 5
- Apache Tomcat
- Eclipse IDE

## Features
- Role-based login for User and Admin
- Users can submit, view and delete their complaints
- Admin can manage all complaints and update their status
- Admin can add remarks visible to the user
- Session management for secure access

## How to Run
1. Import project in Eclipse
2. Create MySQL database `complaint_db`
3. Deploy on Apache Tomcat Server
4. Open: `http://localhost:8181/ComplaintSystem1/jsp/login.jsp`

## Database
- `login` table — stores user credentials and roles
- `complaints` table — stores all complaint details and admin responses

## Test Accounts
- Admin account: username = `admin`
- User accounts: `user1` and `user2`

> Note: Default passwords are set in the MySQL login table.
