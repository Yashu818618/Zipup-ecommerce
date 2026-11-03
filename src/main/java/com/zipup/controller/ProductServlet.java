package com.zipup.controller;

import com.zipup.dao.ProductDAO;
import com.zipup.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        List<Product> productList;

        if (category != null && !category.trim().isEmpty()) {
            productList = productDAO.getProductsByCategory(category);
            request.setAttribute("selectedCategory", category);
        } else {
            productList = productDAO.getAllProducts();
        }

        request.setAttribute("products", productList);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
}