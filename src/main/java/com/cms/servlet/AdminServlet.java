package com.cms.servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.cms.dao.CourseDAO;

public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String courseName = req.getParameter("coursename");
        int teacherId = Integer.parseInt(req.getParameter("teacherid"));

        CourseDAO.addCourse(courseName, teacherId);
        res.sendRedirect("admin.jsp?added=1");
    }
}
