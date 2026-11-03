<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.zipup.model.Order" %>
<%@ page import="com.zipup.model.OrderItem" %>
<%@ page import="com.zipup.model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Order History</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .order-card { background: #fff; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .order-header { display: flex; justify-content: space-between; border-bottom: 1px solid #eee; padding-bottom: 10px; font-size: 14px; color: #555; }
        .item-row { display: flex; align-items: center; gap: 15px; margin-top: 15px; }
        .item-row img { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; }
        .status { padding: 4px 8px; background: #e8f5e9; color: #2e7d32; border-radius: 4px; font-weight: bold; font-size: 12px; }
    </style>
</head>
<body>

<nav>
    <div class="logo">ZIPUP</div>
    <div>
        <a href="products">Shop All</a>
        <a href="cart">Cart</a>
        <a href="wishlist">Wishlist</a>
        <a href="logout">Logout (<%= currentUser != null ? currentUser.getFullName() : "" %>)</a>
    </div>
</nav>

<div class="container">
    <h2>Your Orders</h2>

    <% if (orders != null && !orders.isEmpty()) { 
        for (Order o : orders) { %>
            <div class="order-card">
                <div class="order-header">
                    <div>Order <strong>#<%= o.getId() %></strong> | Date: <%= o.getOrderDate() %></div>
                    <div>Total: <strong>$<%= o.getTotalAmount() %></strong> <span class="status"><%= o.getStatus() %></span></div>
                </div>

                <% if (o.getItems() != null) {
                    for (OrderItem item : o.getItems()) { %>
                        <div class="item-row">
                            <img src="<%= item.getProduct().getImageUrl() %>">
                            <div>
                                <strong><%= item.getProduct().getName() %></strong><br>
                                Size: <%= item.getSelectedSize() %> | Qty: <%= item.getQuantity() %> | Price: $<%= item.getPriceAtPurchase() %>
                            </div>
                        </div>
                <%  }
                   } %>
            </div>
    <%  } 
       } else { %>
        <p>You haven't placed any orders yet. <a href="products">Start Shopping</a></p>
    <% } %>
</div>

</body>
</html>