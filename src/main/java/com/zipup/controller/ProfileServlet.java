package com.zipup.controller;

import com.zipup.dao.UserDAO;
import com.zipup.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String shippingAddress = request.getParameter("shippingAddress");

        user.setFullName(fullName);
        user.setPhoneNumber(phoneNumber);
        user.setShippingAddress(shippingAddress);

        boolean updated = userDAO.updateUserProfile(user);

        if (updated) {
            session.setAttribute("user", user); // Refresh session data
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}