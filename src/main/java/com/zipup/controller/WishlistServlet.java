package com.zipup.controller;

import com.zipup.dao.WishlistDAO;
import com.zipup.model.Product;
import com.zipup.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() {
        wishlistDAO = new WishlistDAO();
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

        List<Product> wishlist = wishlistDAO.getWishlistByUserId(user.getId());
        request.setAttribute("wishlist", wishlist);
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        if ("add".equals(action)) {
            wishlistDAO.addToWishlist(user.getId(), productId);
            response.sendRedirect("wishlist");
        } else if ("remove".equals(action)) {
            wishlistDAO.removeFromWishlist(user.getId(), productId);
            response.sendRedirect("wishlist");
        }
    }
}