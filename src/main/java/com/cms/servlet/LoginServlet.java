package com.cms.servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.cms.dao.UserDAO;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String role = UserDAO.validateUser(username, password);

        if (role != null) {
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            switch (role) {
                case "admin":
                    res.sendRedirect("admin.jsp");
                    break;
                case "teacher":
                    res.sendRedirect("teacher.jsp");
                    break;
                case "student":
                    res.sendRedirect("student.jsp");
                    break;
                default:

                    res.sendRedirect("login.jsp?error=1");
                    break;
            }
        } else {
            res.sendRedirect("login.jsp?error=1");
        }
    }
}
