package com.zipup.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // Change these parameters if your MySQL port, username, or password differ
    private static final String URL = "jdbc:mysql://localhost:3306/Zipup?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root"; 
    private static final String PASSWORD = "Yashu@2003"; // <-- Put your MySQL password here

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish Connection
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to connect to MySQL database Zipup!");
            e.printStackTrace();
        }
        return connection;
    }
}