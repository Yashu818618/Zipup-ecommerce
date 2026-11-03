<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.zipup.model.Product" %>
<%@ page import="com.zipup.model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    List<Product> products = (List<Product>) request.getAttribute("products");
    String selectedCategory = request.getParameter("category");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zipup - Catalog</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        
        /* 4 Core Categories Nav */
        .category-bar { display: flex; gap: 15px; margin-bottom: 30px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .category-bar a { text-decoration: none; color: #555; padding: 8px 16px; border-radius: 20px; font-weight: 600; background: #e0e0e0; transition: 0.2s; }
        .category-bar a.active, .category-bar a:hover { background: #111; color: #fff; }

        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 25px; }
        .card { background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.06); transition: transform 0.2s; }
        .card:hover { transform: translateY(-4px); }
        .card img { width: 100%; height: 260px; object-fit: cover; }
        .card-body { padding: 15px; }
        .card-title { font-weight: 700; font-size: 16px; margin-bottom: 6px; }
        .card-cat { font-size: 12px; color: #888; text-transform: uppercase; margin-bottom: 8px; font-weight: bold; }
        .card-price { font-size: 18px; color: #111; font-weight: 800; margin-bottom: 12px; }
        .btn-view { display: block; text-align: center; background: #111; color: #fff; text-decoration: none; padding: 10px; border-radius: 4px; font-weight: 600; }
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
            <a href="profile">Profile (<%= currentUser.getFullName() %>)</a>
            <a href="logout">Logout</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Sign Up</a>
        <% } %>
    </div>
</nav>

<div class="container">
    <h2>Collection Catalog</h2>

    <!-- Category Filter Bar -->
    <div class="category-bar">
        <a href="products" class="<%= (selectedCategory == null || selectedCategory.isEmpty()) ? "active" : "" %>">All</a>
        <a href="products?category=Hoodies" class="<%= "Hoodies".equals(selectedCategory) ? "active" : "" %>">Hoodies</a>
        <a href="products?category=Jackets" class="<%= "Jackets".equals(selectedCategory) ? "active" : "" %>">Jackets</a>
        <a href="products?category=Tees" class="<%= "Tees".equals(selectedCategory) ? "active" : "" %>">Tees</a>
        <a href="products?category=Pants" class="<%= "Pants".equals(selectedCategory) ? "active" : "" %>">Pants</a>
    </div>

    <div class="grid">
        <% if (products != null && !products.isEmpty()) {
            for (Product p : products) { 
                // Filter by category if param present
                if (selectedCategory != null && !selectedCategory.isEmpty() && !selectedCategory.equalsIgnoreCase(p.getSubCategory())) {
                    continue;
                }
        %>
            <div class="card">
                <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                <div class="card-body">
                    <div class="card-cat"><%= p.getSubCategory() %></div>
                    <div class="card-title"><%= p.getName() %></div>
                    <div class="card-price">₹<%= p.getPrice() %></div>
                    <a href="product-detail?id=<%= p.getId() %>" class="btn-view">View Details</a>
                </div>
            </div>
        <%  } 
           } else { %>
            <p>No products available right now.</p>
        <% } %>
    </div>
</div>

</body>
</html>