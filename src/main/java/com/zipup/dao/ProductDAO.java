package com.zipup.dao;

import com.zipup.model.Product;
import com.zipup.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Fetch all products from database
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Fetch single product by ID
    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT * FROM products WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                product = mapResultSetToProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Fetch products filtered by sub-category (e.g., 'Jackets', 'Hoodies')
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE sub_category = ? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Helper method to map SQL result set to Product object
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        return new Product(
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
    }
}