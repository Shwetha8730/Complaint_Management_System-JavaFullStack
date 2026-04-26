package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import util.DBConnection;

public class UpdateRemarkServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String id = req.getParameter("id");
        String remark = req.getParameter("remark");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE complaints SET admin_remark=? WHERE id=?"
            );
            ps.setString(1, remark);
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/ViewComplaintServlet");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}