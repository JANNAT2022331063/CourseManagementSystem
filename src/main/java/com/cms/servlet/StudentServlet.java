package com.cms.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.cms.dao.DBConnection;

public class StudentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("register".equals(action)) {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            try {
                Connection con = DBConnection.getConnection();

                PreparedStatement check = con.prepareStatement(
                    "SELECT * FROM registrations WHERE student_id=? AND course_id=?");
                check.setInt(1, studentId);
                check.setInt(2, courseId);
                ResultSet rs = check.executeQuery();

                if (!rs.next()) {
                    PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO registrations (student_id, course_id) VALUES (?, ?)");
                    ps.setInt(1, studentId);
                    ps.setInt(2, courseId);
                    ps.executeUpdate();
                    ps.close();
                }

                con.close();
                response.sendRedirect("student.jsp?registered=1");

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        }
    }
}
