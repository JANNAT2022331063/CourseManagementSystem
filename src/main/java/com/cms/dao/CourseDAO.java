package com.cms.dao;
import java.sql.*;

public class CourseDAO {
    public static void addCourse(String name, int teacherId) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO courses (name, teacher_id) VALUES (?,?)");
            ps.setString(1, name);
            ps.setInt(2, teacherId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public static ResultSet getAllCourses() throws SQLException {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        return st.executeQuery("SELECT * FROM courses");
    }
}
