<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 500px;">
    <h2 class="text-center mb-4">Register New User</h2>

    <form action="register" method="post">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" name="username" class="form-control" placeholder="Enter username" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Role:</label>
            <select name="role" class="form-select" required>
                <option value="">-- Select Role --</option>
                <option value="student">Student</option>
                <option value="teacher">Teacher</option>
                <option value="admin">Admin</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Register</button>
    </form>

    <% if(request.getParameter("success") != null) { %>
        <div class="alert alert-success mt-3">Registration successful! <a href="login.jsp">Login here</a>.</div>
    <% } %>

    <% if(request.getParameter("error") != null) { %>
        <div class="alert alert-danger mt-3">Error: Username already exists or invalid input.</div>
    <% } %>
</div>
</body>
</html>
