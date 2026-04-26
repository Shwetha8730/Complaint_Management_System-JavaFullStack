package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import util.DBConnection;

public class DeleteComplaintServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM complaints WHERE id=?"
            );
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();
            res.sendRedirect(req.getContextPath() + "/ViewComplaintServlet");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}