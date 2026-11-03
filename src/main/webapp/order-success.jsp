<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Order Confirmed</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; text-align: center; }
        .card { max-width: 450px; margin: 80px auto; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .icon { font-size: 50px; color: #2e7d32; margin-bottom: 15px; }
        .btn { display: inline-block; background: #111; color: #fff; padding: 12px 24px; text-decoration: none; border-radius: 4px; margin-top: 20px; font-weight: bold; }
    </style>
</head>
<body>

<div class="card">
    <div class="icon">✓</div>
    <h2>Thank You for Your Order!</h2>
    <p>Order ID: <strong>#<%= request.getAttribute("orderId") %></strong></p>
    <p>Your fashion pieces are being prepped for shipment.</p>
    <a href="orders" class="btn">View Order History</a>
</div>

</body>
</html>