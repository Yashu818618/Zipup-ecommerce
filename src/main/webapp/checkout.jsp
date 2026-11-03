<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zipup.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Checkout</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 500px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 16px; }
        label { font-weight: bold; display: block; margin-bottom: 6px; }
        textarea, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; background: #111; color: #fff; padding: 12px; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; margin-top: 10px; }
    </style>
</head>
<body>

<nav>
    <div class="logo">ZIPUP</div>
    <div>
        <a href="products">Shop All</a>
        <a href="cart">Cart</a>
        <a href="orders">Orders</a>
    </div>
</nav>

<div class="container">
    <h2>Checkout</h2>

    <form action="checkout" method="post">
        <div class="form-group">
            <label for="shippingAddress">Shipping Address</label>
            <textarea id="shippingAddress" name="shippingAddress" required><%= currentUser.getShippingAddress() != null ? currentUser.getShippingAddress() : "" %></textarea>
        </div>

        <div class="form-group">
            <label for="paymentMethod">Payment Method</label>
            <select id="paymentMethod" name="paymentMethod" required>
                <option value="Credit Card">Credit / Debit Card</option>
                <option value="PayPal">PayPal</option>
                <option value="Cash on Delivery">Cash on Delivery</option>
            </select>
        </div>

        <button type="submit" class="btn">Place Order</button>
    </form>
</div>

</body>
</html>