<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.zipup.model.Product" %>
<%@ page import="com.zipup.model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    List<Product> wishlist = (List<Product>) request.getAttribute("wishlist");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Wishlist</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        .card { background: #fff; border-radius: 8px; overflow: hidden; padding: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); text-align: center; }
        .card img { width: 100%; height: 220px; object-fit: cover; border-radius: 4px; }
        .title { font-weight: bold; margin: 10px 0 5px; }
        .price { color: #2e7d32; font-weight: bold; margin-bottom: 12px; }
        .btn-remove { background: #d9534f; color: #fff; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
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
    <h2>Your Wishlist</h2>

    <% if (wishlist != null && !wishlist.isEmpty()) { %>
        <div class="grid">
            <% for (Product p : wishlist) { %>
                <div class="card">
                    <img src="<%= p.getImageUrl() %>">
                    <div class="title"><%= p.getName() %></div>
                    <div class="price">$<%= p.getPrice() %></div>
                    <a href="product-detail?id=<%= p.getId() %>" style="display:block; margin-bottom:10px; color:#111;">View Item</a>
                    <form action="wishlist" method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn-remove">Remove</button>
                    </form>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <p>No items in your wishlist yet. <a href="products">Explore catalog</a></p>
    <% } %>
</div>

</body>
</html>