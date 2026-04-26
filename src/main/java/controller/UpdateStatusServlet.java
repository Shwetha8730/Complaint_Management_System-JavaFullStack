package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import util.DBConnection;

public class UpdateStatusServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String id = req.getParameter("id");
        String status = req.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE complaints SET status=? WHERE id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/ViewComplaintServlet");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}