package com.zipup.dao;

import com.zipup.model.CartItem;
import com.zipup.model.Order;
import com.zipup.model.OrderItem;
import com.zipup.model.Product;
import com.zipup.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int createOrder(Order order, List<CartItem> cartItems) {
        String insertOrderQuery = "INSERT INTO orders (user_id, total_amount, shipping_address, payment_method, status) VALUES (?, ?, ?, ?, ?)";
        String insertItemQuery = "INSERT INTO order_items (order_id, product_id, selected_size, quantity, price_at_purchase) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Enable database transaction

            // 1. Insert into orders table
            PreparedStatement orderStmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, order.getUserId());
            orderStmt.setBigDecimal(2, order.getTotalAmount());
            orderStmt.setString(3, order.getShippingAddress());
            orderStmt.setString(4, order.getPaymentMethod());
            orderStmt.setString(5, "PENDING");
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 2. Insert line items into order_items table
            PreparedStatement itemStmt = conn.prepareStatement(insertItemQuery);
            for (CartItem cartItem : cartItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, cartItem.getProductId());
                itemStmt.setString(3, cartItem.getSelectedSize());
                itemStmt.setInt(4, cartItem.getQuantity());
                itemStmt.setBigDecimal(5, cartItem.getProduct().getPrice());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            // 3. Clear user's cart
            PreparedStatement clearCartStmt = conn.prepareStatement("DELETE FROM cart WHERE user_id = ?");
            clearCartStmt.setInt(1, order.getUserId());
            clearCartStmt.executeUpdate();

            conn.commit(); // Commit transaction
            return orderId;

        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return 0;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String orderQuery = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        String itemQuery = "SELECT oi.*, p.name, p.image_url FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement orderStmt = conn.prepareStatement(orderQuery)) {

            orderStmt.setInt(1, userId);
            ResultSet rs = orderStmt.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("shipping_address"),
                    rs.getString("payment_method"),
                    rs.getString("status"),
                    rs.getTimestamp("order_date")
                );

                // Fetch line items
                PreparedStatement itemStmt = conn.prepareStatement(itemQuery);
                itemStmt.setInt(1, order.getId());
                ResultSet itemRs = itemStmt.executeQuery();
                List<OrderItem> items = new ArrayList<>();

                while (itemRs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(itemRs.getInt("id"));
                    item.setOrderId(itemRs.getInt("order_id"));
                    item.setProductId(itemRs.getInt("product_id"));
                    item.setSelectedSize(itemRs.getString("selected_size"));
                    item.setQuantity(itemRs.getInt("quantity"));
                    item.setPriceAtPurchase(itemRs.getBigDecimal("price_at_purchase"));

                    Product p = new Product();
                    p.setName(itemRs.getString("name"));
                    p.setImageUrl(itemRs.getString("image_url"));
                    item.setProduct(p);

                    items.add(item);
                }
                order.setItems(items);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}