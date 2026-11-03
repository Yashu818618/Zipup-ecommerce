package com.zipup.model;

import java.math.BigDecimal;

public class OrderItem {
    private int id;
    private int orderId;
    private int productId;
    private String selectedSize;
    private int quantity;
    private BigDecimal priceAtPurchase;
    private Product product;

    public OrderItem() {}

    public OrderItem(int orderId, int productId, String selectedSize, int quantity, BigDecimal priceAtPurchase) {
        this.orderId = orderId;
        this.productId = productId;
        this.selectedSize = selectedSize;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getSelectedSize() { return selectedSize; }
    public void setSelectedSize(String selectedSize) { this.selectedSize = selectedSize; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getPriceAtPurchase() { return priceAtPurchase; }
    public void setPriceAtPurchase(BigDecimal priceAtPurchase) { this.priceAtPurchase = priceAtPurchase; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
}