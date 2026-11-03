<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.zipup.model.CartItem" %>
<%@ page import="com.zipup.model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    BigDecimal total = BigDecimal.ZERO;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            total = total.add(item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Shopping Cart</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 900px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f4f4f4; }
        .img-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 4px; }

        .total-box { text-align: right; font-size: 20px; font-weight: bold; margin-bottom: 20px; }
        .btn-checkout { display: inline-block; float: right; background: #111; color: #fff; padding: 12px 24px; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .btn-remove { background: #d9534f; color: #fff; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; }
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
    <h2>Your Cart</h2>

    <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Product</th>
                    <th>Size</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Subtotal</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (CartItem item : cartItems) { 
                    BigDecimal subtotal = item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity()));
                %>
                    <tr>
                        <td><img src="<%= item.getProduct().getImageUrl() %>" class="img-thumb"></td>
                        <td><%= item.getProduct().getName() %></td>
                        <td><%= item.getSelectedSize() %></td>
                        <td>$<%= item.getProduct().getPrice() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>$<%= subtotal %></td>
                        <td>
                            <form action="cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartId" value="<%= item.getId() %>">
                                <button type="submit" class="btn-remove">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <div class="total-box">Total: $<%= total %></div>
        <a href="checkout.jsp" class="btn-checkout">Proceed to Checkout</a>
    <% } else { %>
        <p>Your cart is empty. <a href="products">Browse items</a></p>
    <% } %>
</div>

</body>
</html>