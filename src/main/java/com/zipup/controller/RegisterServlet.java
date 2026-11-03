package com.zipup.controller;

import com.zipup.dao.UserDAO;
import com.zipup.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward request to register.jsp view
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieve form fields from request
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String shippingAddress = request.getParameter("shippingAddress");

        // Basic validation check
        if (fullName == null || email == null || password == null || 
            fullName.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All required fields must be filled!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (userDAO.isEmailRegistered(email)) {
            request.setAttribute("errorMessage", "An account with this email already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create new User entity
        User newUser = new User(fullName, email, password, phoneNumber, shippingAddress);

        // Attempt to insert into MySQL
        boolean success = userDAO.registerUser(newUser);

        if (success) {
            request.setAttribute("successMessage", "Registration successful! Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed due to a database error. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}