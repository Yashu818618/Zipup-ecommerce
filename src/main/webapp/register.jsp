<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zipup - Create Account</title>
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
            max-width: 420px;
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
        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        textarea {
            resize: vertical;
            height: 70px;
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

    <form action="register" method="post">
        <div class="form-group">
            <label for="fullName">Full Name *</label>
            <input type="text" id="fullName" name="fullName" required placeholder="John Doe">
        </div>

        <div class="form-group">
            <label for="email">Email Address *</label>
            <input type="email" id="email" name="email" required placeholder="john@example.com">
        </div>

        <div class="form-group">
            <label for="password">Password *</label>
            <input type="password" id="password" name="password" required placeholder="••••••••">
        </div>

        <div class="form-group">
            <label for="phoneNumber">Phone Number</label>
            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="+1 234 567 8900">
        </div>

        <div class="form-group">
            <label for="shippingAddress">Shipping Address</label>
            <textarea id="shippingAddress" name="shippingAddress" placeholder="Street, City, Zip Code"></textarea>
        </div>

        <button type="submit" class="btn">Create Account</button>
    </form>

    <div class="footer-link">
        Already have an account? <a href="login.jsp">Log In</a>
    </div>
</div>

</body>
</html>