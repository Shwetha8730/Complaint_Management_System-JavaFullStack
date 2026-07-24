package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import util.DBConnection;

public class ViewComplaintServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");

        // Redirect to login if not logged in
        if(role == null) {
            res.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        try {
        	Connection con = DBConnection.getConnection();

        	// Dashboard statistics
            int totalComplaints = 0;
            int pendingComplaints = 0;
            int inProgressComplaints = 0;
            int solvedComplaints = 0;

            Statement stmt = con.createStatement();

            ResultSet totalRs = stmt.executeQuery("SELECT COUNT(*) FROM complaints");
            if(totalRs.next())
                totalComplaints = totalRs.getInt(1);

            ResultSet pendingRs = stmt.executeQuery(
                "SELECT COUNT(*) FROM complaints WHERE status='Pending'"
            );
            if(pendingRs.next())
                pendingComplaints = pendingRs.getInt(1);

            ResultSet progressRs = stmt.executeQuery(
                "SELECT COUNT(*) FROM complaints WHERE status='In Progress'"
            );
            if(progressRs.next())
                inProgressComplaints = progressRs.getInt(1);

            ResultSet solvedRs = stmt.executeQuery(
                "SELECT COUNT(*) FROM complaints WHERE status='Solved'"
            );
            if(solvedRs.next())
                solvedComplaints = solvedRs.getInt(1);
            PreparedStatement ps;

            if("admin".equals(role)) {
                ps = con.prepareStatement("SELECT * FROM complaints ORDER BY id DESC");
            } else {
                ps = con.prepareStatement(
                    "SELECT * FROM complaints WHERE created_by=? ORDER BY id DESC"
                );
                ps.setString(1, username);
            }

            ResultSet rs = ps.executeQuery();
            req.setAttribute("data", rs);
            req.setAttribute("role", role);
            req.setAttribute("totalComplaints", totalComplaints);
            req.setAttribute("pendingComplaints", pendingComplaints);
            req.setAttribute("inProgressComplaints", inProgressComplaints);
            req.setAttribute("solvedComplaints", solvedComplaints);
            req.getRequestDispatcher("/jsp/view.jsp").forward(req, res);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}