package com.cms.dao;
import java.sql.*;

public class RegistrationDAO {
    public static void registerCourse(int studentId, int courseId) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO registrations (student_id, course_id) VALUES (?,?)");
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public static ResultSet getRegisteredCourses(int studentId) throws SQLException {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT c.* FROM courses c JOIN registrations r ON c.id=r.course_id WHERE r.student_id=?");
        ps.setInt(1, studentId);
        return ps.executeQuery();
    }
}
