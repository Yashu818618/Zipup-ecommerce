package com.zipup.dao;

import com.zipup.model.Product;
import com.zipup.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public boolean addToWishlist(int userId, int productId) {
        String query = "INSERT IGNORE INTO wishlist (user_id, product_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> getWishlistByUserId(int userId) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.* FROM wishlist w JOIN products p ON w.product_id = p.id WHERE w.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getBigDecimal("price"),
                    rs.getInt("stock"),
                    rs.getString("image_url"),
                    rs.getString("sub_category"),
                    rs.getString("available_sizes"),
                    rs.getTimestamp("created_at")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean removeFromWishlist(int userId, int productId) {
        String query = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}