<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Course Management System</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, #0f2027, #000000 70%);
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #ffffff;
            overflow: hidden;
        }

        /* Main Card */
        .container {
            position: relative;
            width: 760px;
            height: 420px;
            background: rgba(10, 18, 22, 0.9);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid rgba(0, 234, 255, 0.35);
            backdrop-filter: blur(12px);
            box-shadow:
                0 0 30px rgba(0, 234, 255, 0.35),
                inset 0 0 30px rgba(0, 234, 255, 0.1);
        }

        /* Neon angled panel */
        .container::before {
            content: "";
            position: absolute;
            left: -160px;
            top: -60px;
            width: 62%;
            height: 130%;
            background: linear-gradient(135deg, #00eaff, #008cff);
            transform: skewX(-18deg);
            box-shadow: 0 0 55px rgba(0, 234, 255, 0.7);
            z-index: 1;
        }

        /* Welcome text */
        .welcome-text {
            position: absolute;
            left: 70px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
            max-width: 280px;
        }

        .welcome-text h1 {
            font-size: 2.7em;
            margin: 0;
            font-weight: 600;
            letter-spacing: 1px;
            color: #ffffff;
            text-shadow: 0 0 15px rgba(255,255,255,0.4);
        }

        .welcome-text p {
            margin-top: 14px;
            font-size: 1.1em;
            line-height: 1.6;
            color: #e0f7fa;
        }

        /* Right content */
        .right-content {
            position: absolute;
            right: 80px;
            top: 50%;
            transform: translateY(-50%);
            text-align: center;
            z-index: 2;
        }

        .right-content a {
            display: inline-block;
            background: linear-gradient(135deg, #00eaff, #008cff);
            color: #000000;
            padding: 15px 42px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 0 22px rgba(0, 234, 255, 0.7);
            transition: all 0.3s ease;
        }

        .right-content a:hover {
            transform: translateY(-3px);
            box-shadow: 0 0 38px rgba(0, 234, 255, 1);
        }

        /* Footer */
        footer {
            position: absolute;
            bottom: 18px;
            width: 100%;
            text-align: center;
            color: #7fdce6;
            font-size: 0.9em;
            letter-spacing: 0.4px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                width: 92%;
                height: 380px;
            }

            .welcome-text {
                left: 40px;
            }

            .right-content {
                right: 40px;
            }
        }
    </style>
</head>

<body>

    <div class="container">

        <div class="welcome-text">
            <h1>WELCOME</h1>
            <p>to the Course Management System</p>
        </div>

        <div class="right-content">
            <a href="login.jsp">GET STARTED</a>
        </div>

    </div>

    <footer>
        © <%= java.time.Year.now() %> Course Management System. All rights reserved.
    </footer>

</body>
</html>
