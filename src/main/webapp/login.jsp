<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zipup - Log In</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            text-align: center;
            margin-bottom: 24px;
            color: #111;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #111;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.2s ease;
        }
        .btn:hover {
            background-color: #333;
        }
        .msg-error {
            color: #d9534f;
            background-color: #fdf7f7;
            border: 1px solid #d9534f;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .msg-success {
            color: #5cb85c;
            background-color: #f0f9f0;
            border: 1px solid #5cb85c;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .footer-link {
            text-align: center;
            margin-top: 18px;
            font-size: 14px;
        }
        .footer-link a {
            color: #111;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>ZIPUP</h2>

    <% String error = (String) request.getAttribute("errorMessage"); %>
    <% if (error != null) { %>
        <div class="msg-error"><%= error %></div>
    <% } %>

    <% String success = (String) request.getAttribute("successMessage"); %>
    <% if (success != null) { %>
        <div class="msg-success"><%= success %></div>
    <% } %>

    <form action="login" method="post">
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required placeholder="john@example.com">
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="••••••••">
        </div>

        <button type="submit" class="btn">Log In</button>
    </form>

    <div class="footer-link">
        Don't have an account? <a href="register.jsp">Sign Up</a>
    </div>
</div>

</body>
</html>