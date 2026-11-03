<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zipup.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Exclusive Fashion</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #000; color: #fff; margin: 0; }
        nav { padding: 20px 50px; display: flex; justify-content: space-between; align-items: center; background: #111; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 28px; font-weight: bold; letter-spacing: 3px; }

        .hero { height: 80vh; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; padding: 0 20px; }
        .hero h1 { font-size: 60px; margin: 0 0 20px 0; letter-spacing: 4px; text-transform: uppercase; }
        .hero p { font-size: 20px; color: #aaa; margin-bottom: 30px; max-width: 600px; }
        .btn-shop { background: #fff; color: #000; padding: 15px 35px; text-decoration: none; font-size: 18px; font-weight: bold; border-radius: 4px; transition: 0.2s; }
        .btn-shop:hover { background: #ddd; }
    </style>
</head>
<body>

<nav>
    <div class="logo">ZIPUP</div>
    <div>
        <a href="products">Catalog</a>
        <% if (currentUser != null) { %>
            <a href="cart">Cart</a>
            <a href="wishlist">Wishlist</a>
            <a href="orders">Orders</a>
            <a href="logout">Logout (<%= currentUser.getFullName() %>)</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Sign Up</a>
        <% } %>
    </div>
</nav>

<div class="hero">
    <h1>ZIPUP FASHION</h1>
    <p>Exclusive minimalist streetwear and everyday apparel collections.</p>
    <a href="products" class="btn-shop">Explore Collection</a>
</div>

</body>
</html>