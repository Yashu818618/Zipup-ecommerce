package com.zipup.dao;

import com.zipup.model.User;
import com.zipup.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Register a new user into MySQL
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (full_name, email, password, phone_number, shipping_address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getPhoneNumber());
            pstmt.setString(5, user.getShippingAddress());

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Authenticate existing user for login
    public User loginUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        User user = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("phone_number"),
                    rs.getString("shipping_address"),
                    rs.getTimestamp("created_at")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Check if an email is already registered
    public boolean isEmailRegistered(String email) {
        String query = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public boolean updateUserProfile(User user) {
        String query = "UPDATE users SET full_name = ?, phone_number = ?, shipping_address = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getPhoneNumber());
            pstmt.setString(3, user.getShippingAddress());
            pstmt.setInt(4, user.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
}