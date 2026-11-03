package com.zipup.controller;

import com.zipup.dao.CartDAO;
import com.zipup.model.CartItem;
import com.zipup.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
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

        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
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

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String size = request.getParameter("size");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            cartDAO.addToCart(user.getId(), productId, size, quantity);
            response.sendRedirect("cart");

        } else if ("remove".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            cartDAO.removeFromCart(cartId, user.getId());
            response.sendRedirect("cart");
        }
    }
}