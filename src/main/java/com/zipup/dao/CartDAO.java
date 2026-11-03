package com.zipup.dao;

import com.zipup.model.CartItem;
import com.zipup.model.Product;
import com.zipup.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public boolean addToCart(int userId, int productId, String size, int quantity) {
        // Check if same item & size exists in cart
        String checkQuery = "SELECT id, quantity FROM cart WHERE user_id = ? AND product_id = ? AND selected_size = ?";
        String updateQuery = "UPDATE cart SET quantity = quantity + ? WHERE id = ?";
        String insertQuery = "INSERT INTO cart (user_id, product_id, selected_size, quantity) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            checkStmt.setString(3, size);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int cartId = rs.getInt("id");
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, cartId);
                return updateStmt.executeUpdate() > 0;
            } else {
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, productId);
                insertStmt.setString(3, size);
                insertStmt.setInt(4, quantity);
                return insertStmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CartItem> getCartByUserId(int userId) {
        List<CartItem> list = new ArrayList<>();
        String query = "SELECT c.*, p.name, p.price, p.image_url FROM cart c " +
                       "JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setImageUrl(rs.getString("image_url"));

                CartItem item = new CartItem(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("product_id"),
                    rs.getString("selected_size"),
                    rs.getInt("quantity"),
                    p
                );
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean removeFromCart(int cartId, int userId) {
        String query = "DELETE FROM cart WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, cartId);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean clearCart(int userId) {
        String query = "DELETE FROM cart WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}