package com.zipup.model;

public class CartItem {
    private int id;
    private int userId;
    private int productId;
    private String selectedSize;
    private int quantity;
    private Product product; // Included for displaying product details in cart

    public CartItem() {}

    public CartItem(int id, int userId, int productId, String selectedSize, int quantity, Product product) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.selectedSize = selectedSize;
        this.quantity = quantity;
        this.product = product;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getSelectedSize() { return selectedSize; }
    public void setSelectedSize(String selectedSize) { this.selectedSize = selectedSize; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
}