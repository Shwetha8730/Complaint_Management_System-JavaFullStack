package util;

import java.sql.*;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/complaint_db",
                "root",
                "shwetha"    // ← change to YOUR MySQL password
            );
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}