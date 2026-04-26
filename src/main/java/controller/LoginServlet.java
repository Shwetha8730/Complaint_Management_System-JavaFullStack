package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import util.DBConnection;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM login WHERE username=? AND password=?"
            );
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", rs.getString("role"));

                if(rs.getString("role").equals("admin")) {
                    res.sendRedirect(req.getContextPath() + "/ViewComplaintServlet");
                } else {
                    res.sendRedirect(req.getContextPath() + "/jsp/home.jsp");
                }
            } else {
                res.sendRedirect(req.getContextPath() + "/jsp/login.jsp?error=1");
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}