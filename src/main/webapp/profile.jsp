<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zipup.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String successMsg = (String) request.getAttribute("successMessage");
    String errorMsg = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Account Profile</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 600px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .form-group { margin-bottom: 18px; }
        label { font-weight: bold; display: block; margin-bottom: 6px; color: #333; }
        input[type="text"], input[type="email"], textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        input[disabled] { background: #eee; cursor: not-allowed; }
        .btn { background: #111; color: #fff; border: none; padding: 12px 24px; border-radius: 4px; font-weight: bold; cursor: pointer; width: 100%; font-size: 15px; }
        .btn:hover { background: #333; }
        .msg-success { color: #2e7d32; background: #e8f5e9; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .msg-error { color: #c62828; background: #ffebee; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .quick-links { margin-top: 25px; pt: 15px; border-top: 1px solid #eee; display: flex; gap: 15px; }
        .quick-links a { color: #111; font-weight: 600; text-decoration: underline; }
    </style>
</head>
<body>

<nav>
    <div class="logo">ZIPUP</div>
    <div>
        <a href="products">Catalog</a>
        <a href="cart">Cart</a>
        <a href="wishlist">Wishlist</a>
        <a href="orders">Orders</a>
        <a href="profile">Profile</a>
        <a href="logout">Logout</a>
    </div>
</nav>

<div class="container">
    <h2>Account Profile</h2>

    <% if (successMsg != null) { %><div class="msg-success"><%= successMsg %></div><% } %>
    <% if (errorMsg != null) { %><div class="msg-error"><%= errorMsg %></div><% } %>

    <form action="profile" method="post">
        <div class="form-group">
            <label>Email Address (Account Identifier)</label>
            <input type="email" value="<%= user.getEmail() %>" disabled>
        </div>

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() %>" required>
        </div>

        <div class="form-group">
            <label for="phoneNumber">Phone Number</label>
            <input type="text" id="phoneNumber" name="phoneNumber" value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>">
        </div>

        <div class="form-group">
            <label for="shippingAddress">Default Shipping Address</label>
            <textarea id="shippingAddress" name="shippingAddress" rows="3"><%= user.getShippingAddress() != null ? user.getShippingAddress() : "" %></textarea>
        </div>

        <button type="submit" class="btn">Save Profile Changes</button>
    </form>

    <div class="quick-links">
        <a href="orders">View Order History</a>
        <a href="wishlist">View Wishlist</a>
    </div>
</div>

</body>
</html>