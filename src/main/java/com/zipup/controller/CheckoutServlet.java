package com.zipup.controller;

import com.zipup.dao.CartDAO;
import com.zipup.dao.OrderDAO;
import com.zipup.model.CartItem;
import com.zipup.model.Order;
import com.zipup.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
        orderDAO = new OrderDAO();
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

        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())));
        }

        Order order = new Order(user.getId(), total, shippingAddress, paymentMethod, "PENDING");
        int orderId = orderDAO.createOrder(order, cartItems);

        if (orderId > 0) {
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("order-success.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Failed to place order. Try again.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}