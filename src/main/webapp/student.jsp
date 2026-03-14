<%@ page import="java.sql.*, com.cms.dao.DBConnection" %>

<%
    // Block access if not logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    int studentId = 0;

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            studentId = rs.getInt("id");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, #0f2027, #000000 70%);
            margin: 0;
            padding: 40px 0;
            color: #ffffff;
            text-align: center;
            position: relative;
        }

        h1 {
            font-weight: 600;
            margin-bottom: 30px;
            color: #00eaff;
            text-shadow: 0 0 12px rgba(0,234,255,0.6);
        }

        h2 {
            margin-top: 10px;
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

        /* Dashboard Box */
        .dashboard-box {
            width: 88%;
            margin: 30px auto;
            background: rgba(10, 18, 22, 0.85);
            border-radius: 18px;
            padding: 30px 20px;
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
            padding: 8px 20px;
            border-radius: 20px;
            border: none;
            font-weight: 600;
            background: linear-gradient(135deg, #00eaff, #008cff);
            color: #000;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            box-shadow: 0 0 25px rgba(0,234,255,0.9);
        }

        .msg {
            margin-top: 20px;
            color: #9affc6;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .dashboard-box {
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

<div class="dashboard-box">
    <h2>Available Courses</h2>

    <%
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM courses");
            ResultSet rs = ps.executeQuery();
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Course Name</th>
            <th>Teacher ID</th>
            <th>Action</th>
        </tr>

        <% while (rs.next()) {
            int courseId = rs.getInt("id");
        %>
        <tr>
            <td><%= courseId %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getInt("teacher_id") %></td>
            <td>
                <form action="student" method="post">
                    <input type="hidden" name="action" value="register">
                    <input type="hidden" name="studentId" value="<%= studentId %>">
                    <input type="hidden" name="courseId" value="<%= courseId %>">
                    <button type="submit">Register</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <% if (request.getParameter("registered") != null) { %>
        <p class="msg">Successfully registered!</p>
    <% } %>

    <%
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>

<div class="dashboard-box">
    <h2>My Registered Courses</h2>

    <%
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT c.id, c.name, c.teacher_id FROM courses c " +
                "JOIN registrations r ON c.id = r.course_id " +
                "WHERE r.student_id=?");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Course</th>
            <th>Teacher ID</th>
        </tr>

        <%
            boolean has = false;
            while (rs.next()) {
                has = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getInt("teacher_id") %></td>
        </tr>
        <% } %>

        <% if (!has) { %>
        <tr>
            <td colspan="3">No courses registered</td>
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

</body>
</html>
