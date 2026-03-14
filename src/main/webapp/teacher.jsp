<%@ page import="java.sql.*, com.cms.dao.DBConnection" %>

<%
    // 🔐 Protect page
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    int teacherId = 0;

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            teacherId = rs.getInt("id");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    String viewCourseId = request.getParameter("courseId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, #0f2027, #000000 70%);
            color: #ffffff;
            min-height: 100vh;
            margin: 0;
            padding: 40px 0;
            text-align: center;
            position: relative;
        }

        h1 {
            font-weight: 600;
            margin-bottom: 10px;
            color: #00eaff;
            text-shadow: 0 0 12px rgba(0,234,255,0.6);
        }

        h2 {
            margin-top: 25px;
            margin-bottom: 25px;
            color: #b2f5ff;
            font-weight: 500;
        }

        /* 🔴 Logout Button */
        .logout-box {
            position: absolute;
            top: 25px;
            right: 40px;
        }

        .logout-box button {
            padding: 8px 22px;
            border-radius: 22px;
            border: none;
            font-weight: 600;
            background: linear-gradient(135deg, #ff5252, #ff1744);
            color: #ffffff;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 0 15px rgba(255,82,82,0.6);
        }

        .logout-box button:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 28px rgba(255,82,82,0.9);
        }

        /* Main Box */
        .dashboard {
            width: 88%;
            margin: auto;
            background: rgba(10, 18, 22, 0.85);
            border-radius: 18px;
            padding: 35px 25px;
            backdrop-filter: blur(12px);
            border: 1px solid rgba(0,234,255,0.3);
            box-shadow:
                0 0 25px rgba(0,234,255,0.25),
                inset 0 0 25px rgba(0,234,255,0.08);
        }

        table {
            width: 95%;
            margin: auto;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
        }

        th {
            padding: 14px;
            background: rgba(0,234,255,0.15);
            color: #00eaff;
            font-weight: 600;
        }

        td {
            padding: 12px;
            background: rgba(255,255,255,0.03);
            color: #e0f7fa;
        }

        tr:hover td {
            background: rgba(0,234,255,0.08);
        }

        button {
            padding: 8px 22px;
            border-radius: 20px;
            border: none;
            font-weight: 600;
            background: linear-gradient(135deg, #00eaff, #008cff);
            color: #000;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 0 15px rgba(0,234,255,0.6);
        }

        button:hover {
            box-shadow: 0 0 28px rgba(0,234,255,0.9);
        }

        .sub-section {
            margin-top: 50px;
        }

        footer {
            text-align: center;
            margin-top: 40px;
            color: #7fdce6;
            font-size: 0.9em;
        }

        @media (max-width: 768px) {
            .dashboard {
                width: 95%;
            }
        }
    </style>
</head>

<body>

<div class="logout-box">
    <form action="logout" method="post">
        <button type="submit">Logout</button>
    </form>
</div>

<h1>Welcome, <%= username %></h1>

<div class="dashboard">

    <h2>Your Courses</h2>

    <%
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM courses WHERE teacher_id=?");
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Course Name</th>
            <th>Action</th>
        </tr>

        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td>
                <form method="get" action="teacher.jsp">
                    <input type="hidden" name="courseId" value="<%= rs.getInt("id") %>">
                    <button type="submit">View Students</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <%
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <% if (viewCourseId != null) { %>
    <div class="sub-section">
        <h2>Students Registered (Course ID: <%= viewCourseId %>)</h2>

        <%
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                    "SELECT u.id, u.username FROM users u " +
                    "JOIN registrations r ON u.id = r.student_id " +
                    "WHERE r.course_id=?");
                ps.setInt(1, Integer.parseInt(viewCourseId));
                ResultSet rs = ps.executeQuery();
        %>

        <table>
            <tr>
                <th>Student ID</th>
                <th>Student Name</th>
            </tr>

            <%
                boolean hasStudents = false;
                while (rs.next()) {
                    hasStudents = true;
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("username") %></td>
            </tr>
            <% } %>

            <% if (!hasStudents) { %>
            <tr>
                <td colspan="2">No students registered yet.</td>
            </tr>
            <% } %>
        </table>

        <%
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    <% } %>

</div>

<footer>
    © <%= java.time.Year.now() %> Course Management System. All rights reserved.
</footer>

</body>
</html>
