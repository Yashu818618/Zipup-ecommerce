package com.zipup.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int id;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String imageUrl;
    private String subCategory;
    private String availableSizes;
    private Timestamp createdAt;

    // Constructors
    public Product() {}

    public Product(String name, String description, BigDecimal price, int stock, String imageUrl, String subCategory, String availableSizes) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.imageUrl = imageUrl;
        this.subCategory = subCategory;
        this.availableSizes = availableSizes;
    }

    public Product(int id, String name, String description, BigDecimal price, int stock, String imageUrl, String subCategory, String availableSizes, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.imageUrl = imageUrl;
        this.subCategory = subCategory;
        this.availableSizes = availableSizes;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getSubCategory() { return subCategory; }
    public void setSubCategory(String subCategory) { this.subCategory = subCategory; }

    public String getAvailableSizes() { return availableSizes; }
    public void setAvailableSizes(String availableSizes) { this.availableSizes = availableSizes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}