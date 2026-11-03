package com.zipup.controller;

import com.zipup.dao.ProductDAO;
import com.zipup.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int productId = Integer.parseInt(idParam);
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("product-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("products");
    }
}