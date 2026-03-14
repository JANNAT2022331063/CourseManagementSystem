package com.cms.servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.cms.dao.DBConnection;

public class TeacherServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {
        String teacherId = req.getParameter("teacherid");
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT c.name, u.username FROM registrations r JOIN users u ON r.student_id=u.id JOIN courses c ON r.course_id=c.id WHERE c.teacher_id=?");
            ps.setString(1, teacherId);
            ResultSet rs = ps.executeQuery();
            req.setAttribute("students", rs);
            RequestDispatcher rd = req.getRequestDispatcher("teacher.jsp");
            rd.forward(req, res);
        } catch (Exception e) { e.printStackTrace(); }
    }
}
