# Complaint Management System — Java Full Stack

A web-based complaint management system where students can raise complaints online with category and urgency levels, and admins can track, manage, and resolve them efficiently.

![Java](https://img.shields.io/badge/Java-Servlets-blue)
![MySQL](https://img.shields.io/badge/Database-MySQL-green)
![Bootstrap](https://img.shields.io/badge/UI-Bootstrap%205-purple)
![Tomcat](https://img.shields.io/badge/Server-Apache%20Tomcat-orange)

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | JSP, Bootstrap 5, HTML/CSS |
| Backend | Java Servlets |
| Database | MySQL with JDBC |
| Server | Apache Tomcat |
| IDE | Eclipse |

---

## Features

### Student
- Register and log in securely
- Submit complaints with **category** and **urgency level**
- View their own complaint history and current status
- Delete their submitted complaints
- View admin remarks on each complaint

### Admin
- View all complaints from all users
- Update complaint status — `Pending` / `In Progress` / `Solved`
- Add remarks visible to the student
- Role-based session-secured access

---

## Database Schema

### `login`
| Column | Type | Description |
|---|---|---|
| username | VARCHAR (PK) | Unique login identifier |
| password | VARCHAR | User password |
| role | ENUM | `admin` or `user` |

### `complaints`
| Column | Type | Description |
|---|---|---|
| id | INT (PK) | Auto-increment complaint ID |
| title | VARCHAR | Short complaint title |
| description | TEXT | Detailed complaint content |
| category | VARCHAR | Complaint category |
| urgency | VARCHAR | Urgency level (Low / Medium / High) |
| status | VARCHAR | `Pending` / `In Progress` / `Solved` |
| created_by | VARCHAR | FK → login.username |
| admin_remark | TEXT | Admin's response note |

---

## Getting Started

**1. Clone the repository**
```bash
git clone https://github.com/your-username/ComplaintSystem.git
```

**2. Set up the database**

Open MySQL Workbench and run:

```sql
CREATE DATABASE complaint_db;
USE complaint_db;

CREATE TABLE login (
  username VARCHAR(50) PRIMARY KEY,
  password VARCHAR(50),
  role ENUM('admin', 'user')
);

CREATE TABLE complaints (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  description TEXT,
  category VARCHAR(50),
  urgency VARCHAR(20),
  status VARCHAR(20) DEFAULT 'Pending',
  created_by VARCHAR(50),
  admin_remark TEXT,
  FOREIGN KEY (created_by) REFERENCES login(username)
);
```

**3. Import into Eclipse**
- `File → Import → General → Existing Projects into Workspace`
- Select the project folder → Finish

**4. Deploy on Tomcat**
- Right-click project → `Run As → Run on Server`
- Select Apache Tomcat v9.0 → Finish

**5. Open in browser**
```
http://localhost:8181/ComplaintSystem1/jsp/login.jsp
```

---

## Test Accounts

> Passwords are set directly in the MySQL `login` table.

| Role | Username |
|---|---|
| Admin | `admin` |
| User | `user1` |
| User | `user2` |

---

## Project Structure

```
ComplaintSystem/
├── src/
│   └── servlets/         # Java Servlets for all actions
├── WebContent/
│   ├── jsp/              # JSP pages (login, dashboard, complaint form)
│   └── css/              # Stylesheets
└── README.md
```

---

> Built with Java Servlets · JSP · MySQL · Bootstrap 5 · Apache Tomcat
