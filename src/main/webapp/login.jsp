<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Course Management System</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: radial-gradient(circle at top, #0f2027, #000000 70%);
            color: #ffffff;
        }

        /* Login Card */
        .login-container {
            width: 400px;
            padding: 45px 40px;
            background: rgba(15, 25, 30, 0.75);
            border-radius: 18px;
            backdrop-filter: blur(12px);
            box-shadow:
                0 0 25px rgba(0, 234, 255, 0.35),
                inset 0 0 25px rgba(0, 234, 255, 0.1);
            border: 1px solid rgba(0, 234, 255, 0.35);
            text-align: center;
        }

        .login-container h2 {
            font-weight: 600;
            margin-bottom: 30px;
            letter-spacing: 1px;
            color: #00eaff;
            text-shadow: 0 0 12px rgba(0, 234, 255, 0.6);
        }

        /* Inputs */
        .form-control {
            background: transparent;
            border: 1px solid rgba(0, 234, 255, 0.45);
            border-radius: 30px;
            padding: 12px 18px;
            margin-bottom: 20px;
            color: #ffffff;
            font-size: 0.95rem;
            text-align: center;
        }

        .form-control::placeholder {
            color: #9fdfe6;
        }

        .form-control:focus {
            outline: none;
            border-color: #00eaff;
            box-shadow: 0 0 12px rgba(0, 234, 255, 0.8);
            background: transparent;
            color: #ffffff;
        }

        /* Button */
        .btn-login {
            width: 100%;
            padding: 12px;
            border-radius: 30px;
            border: none;
            font-weight: 600;
            letter-spacing: 0.5px;
            background: linear-gradient(135deg, #00eaff, #008cff);
            color: #000000;
            transition: all 0.3s ease;
            box-shadow: 0 0 18px rgba(0, 234, 255, 0.6);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 30px rgba(0, 234, 255, 0.9);
        }

        /* Error */
        .error {
            margin-top: 18px;
            color: #ffb3b3;
            font-size: 0.9em;
            text-shadow: 0 0 6px rgba(255, 0, 0, 0.5);
        }
    </style>
</head>

<body>

    <div class="login-container">
        <h2>WELCOME BACK</h2>

        <form action="login" method="post">
            <input type="text" name="username" class="form-control" placeholder="Username" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <button type="submit" class="btn-login">LOGIN</button>
        </form>

        <% if (request.getParameter("error") != null) { %>
            <div class="error">Invalid username or password</div>
        <% } %>
    </div>

</body>
</html>
