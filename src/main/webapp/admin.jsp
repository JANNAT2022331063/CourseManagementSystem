<%@ page import="java.sql.*, com.cms.dao.DBConnection" %>
<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM courses");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, #0f2027, #000000 70%);
            color: #ffffff;
            min-height: 100vh;
            padding: 0;
            margin: 0;
        }

        /* Navbar */
        .navbar {
            padding: 18px 40px;
            background: rgba(10,18,22,0.9);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(0,234,255,0.25);
            box-shadow: 0 0 20px rgba(0,234,255,0.25);
        }

        .navbar-brand {
            font-weight: 600;
            letter-spacing: 1px;
            color: #00eaff !important;
            text-shadow: 0 0 12px rgba(0,234,255,0.6);
        }

        .logout-btn {
            background: linear-gradient(135deg, #ff5252, #ff1744);
            border: none;
            padding: 8px 22px;
            border-radius: 20px;
            color: #fff;
            font-weight: 600;
            box-shadow: 0 0 15px rgba(255,82,82,0.6);
            transition: 0.3s;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 25px rgba(255,82,82,0.9);
        }

        h3 {
            text-align: center;
            font-weight: 600;
            letter-spacing: 1px;
            margin: 40px 0 30px;
            color: #00eaff;
            text-shadow: 0 0 12px rgba(0,234,255,0.6);
        }

        .box {
            max-width: 950px;
            margin: auto;
            padding: 35px;
            border-radius: 18px;
            background: rgba(15, 25, 30, 0.7);
            backdrop-filter: blur(10px);
            box-shadow:
                0 0 25px rgba(0, 234, 255, 0.25),
                inset 0 0 25px rgba(0, 234, 255, 0.08);
            border: 1px solid rgba(0, 234, 255, 0.25);
        }

        /* Form */
        form input {
            background: transparent;
            border: 1px solid rgba(0, 234, 255, 0.4);
            border-radius: 10px;
            padding: 12px;
            width: 220px;
            color: #ffffff;
            outline: none;
        }

        form input::placeholder {
            color: #9fdfe6;
        }

        form input:focus {
            box-shadow: 0 0 10px rgba(0, 234, 255, 0.6);
            border-color: #00eaff;
        }

        form button {
            padding: 12px 26px;
            border-radius: 12px;
            font-weight: 600;
            background: linear-gradient(135deg, #00eaff, #008cff);
            border: none;
            color: #000;
            transition: 0.3s;
            box-shadow: 0 0 15px rgba(0, 234, 255, 0.6);
        }

        form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 25px rgba(0, 234, 255, 0.9);
        }

        /* Table */
        table {
            margin-top: 30px;
            border-radius: 12px;
            overflow: hidden;
            background: rgba(0, 0, 0, 0.6);
        }

        table th {
            background: rgba(0, 234, 255, 0.15);
            color: #00eaff;
            font-weight: 600;
            text-align: center;
            border: none;
        }

        table td {
            background: rgba(255, 255, 255, 0.03);
            text-align: center;
            border: none;
            color: #e0f7fa;
        }

        table tr:hover td {
            background: rgba(0, 234, 255, 0.08);
        }
    </style>
</head>

<body>

<nav class="navbar d-flex justify-content-between">
    <span class="navbar-brand">ADMIN PANEL</span>
    <form action="logout" method="post">
        <button class="logout-btn">Logout</button>
    </form>
</nav>

<h3>MANAGE COURSES</h3>

<div class="box">

    <form action="admin" method="post" class="d-flex justify-content-center gap-3 mb-4">
        <input type="text" name="coursename" placeholder="Course Name" required>
        <input type="text" name="teacherid" placeholder="Teacher ID" required>
        <button>Add Course</button>
    </form>

    <table class="table">
        <tr>
            <th>ID</th>
            <th>Course</th>
            <th>Teacher ID</th>
        </tr>

        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getInt("teacher_id") %></td>
        </tr>
        <% } %>
    </table>

</div>

</body>
</html>
