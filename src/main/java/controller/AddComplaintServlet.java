package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import util.DBConnection;

public class AddComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false); // <-- important change
        String username = (String) session.getAttribute("username");

        System.out.println("DEBUG: username from session = " + username); // for checking

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String category = req.getParameter("category");
        String urgency = req.getParameter("urgency");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO complaints(title, description, category, urgency, status, created_by) VALUES(?,?,?,?,?,?)"
            );
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, urgency);
            ps.setString(5, "Pending");
            ps.setString(6, username); // <-- this was saving null before
            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/ViewComplaintServlet");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}