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
            req.getRequestDispatcher("/jsp/view.jsp").forward(req, res);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}