<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zipup.model.Product" %>
<%@ page import="com.zipup.model.User" %>
<%
    Product p = (Product) request.getAttribute("product");
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= p != null ? p.getName() : "Product Details" %> - Zipup</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; }
        nav { background: #111; color: #fff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        nav a { color: #fff; text-decoration: none; margin-left: 20px; font-weight: 500; }
        .logo { font-size: 24px; font-weight: bold; letter-spacing: 2px; }

        .container { max-width: 1100px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 12px; display: flex; gap: 40px; box-shadow: 0 4px 15px rgba(0,0,0,0.06); }
        .img-column { flex: 1; display: flex; flex-direction: column; gap: 20px; }
        .img-column img.main-img { width: 100%; height: 500px; object-fit: cover; border-radius: 8px; }
        
        /* Size Guide Box */
        .size-guide-card { background: #fafafa; border: 1px dashed #ccc; padding: 15px; border-radius: 8px; text-align: center; }
        .size-guide-card h4 { margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; color: #333; }
        .size-table { width: 100%; border-collapse: collapse; font-size: 12px; color: #555; }
        .size-table th, .size-table td { border: 1px solid #ddd; padding: 6px; }
        .size-table th { background: #eee; }

        .details { flex: 1; }
        .category-tag { color: #777; font-size: 13px; font-weight: bold; text-transform: uppercase; }
        h1 { margin: 5px 0 15px 0; font-size: 30px; letter-spacing: -0.5px; }
        .price { font-size: 26px; color: #111; font-weight: 800; margin-bottom: 20px; }
        .desc { color: #555; line-height: 1.7; margin-bottom: 25px; }

        .form-group { margin-bottom: 20px; }
        label { font-weight: bold; display: block; margin-bottom: 8px; }
        select, input[type="number"] { padding: 10px 14px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; }
        
        .btn-group { display: flex; gap: 15px; margin-top: 25px; }
        .btn { padding: 14px 28px; font-weight: bold; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 15px; }
        .btn-cart { background: #111; color: #fff; flex: 2; }
        .btn-wishlist { background: #f0f0f0; color: #111; flex: 1; text-align: center; }
        .btn-cart:hover { background: #333; }
        .btn-wishlist:hover { background: #e0e0e0; }
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
            <a href="profile">Profile</a>
            <a href="logout">Logout</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Sign Up</a>
        <% } %>
    </div>
</nav>

<% if (p != null) { %>
<div class="container">
    <div class="img-column">
        <!-- Main Product Image -->
        <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>" class="main-img">

        <!-- Visual Size Guide Reference -->
        <div class="size-guide-card">
            <h4>📐 <%= p.getSubCategory() %> Fit & Size Reference</h4>
            <table class="size-table">
                <thead>
                    <tr>
                        <th>Size</th>
                        <th>Chest/Waist</th>
                        <th>Length</th>
                    </tr>
                </thead>
                <tbody>
                    <% if ("Pants".equalsIgnoreCase(p.getSubCategory())) { %>
                        <tr><td>30</td><td>30 in</td><td>40 in</td></tr>
                        <tr><td>32</td><td>32 in</td><td>41 in</td></tr>
                        <tr><td>34</td><td>34 in</td><td>42 in</td></tr>
                        <tr><td>36</td><td>36 in</td><td>42.5 in</td></tr>
                    <% } else { %>
                        <tr><td>S</td><td>38 - 40 in</td><td>27 in</td></tr>
                        <tr><td>M</td><td>40 - 42 in</td><td>28 in</td></tr>
                        <tr><td>L</td><td>42 - 44 in</td><td>29 in</td></tr>
                        <tr><td>XL</td><td>44 - 46 in</td><td>30 in</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="details">
        <div class="category-tag"><%= p.getSubCategory() %></div>
        <h1><%= p.getName() %></h1>
        <div class="price">₹<%= p.getPrice() %></div>
        <p class="desc"><%= p.getDescription() %></p>

        <form action="cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="productId" value="<%= p.getId() %>">

            <div class="form-group">
                <label for="size">Select Size:</label>
                <select id="size" name="size" required>
                    <% 
                        String[] sizes = p.getAvailableSizes().split(",");
                        for (String s : sizes) { 
                    %>
                        <option value="<%= s.trim() %>"><%= s.trim() %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= p.getStock() %>">
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-cart">Add to Cart</button>
        </form>

        <form action="wishlist" method="post" style="display:inline; width:100%;">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="productId" value="<%= p.getId() %>">
            <button type="submit" class="btn btn-wishlist">❤️ Wishlist</button>
        </form>
            </div>
    </div>
</div>
<% } %>

</body>
</html>