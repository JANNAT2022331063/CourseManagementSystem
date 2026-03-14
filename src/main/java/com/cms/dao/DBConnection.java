package com.cms.dao;
import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql:
    private static final String USER = "root";
    private static final String PASSWORD = "Allah1234*jannatbhuiyan";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
