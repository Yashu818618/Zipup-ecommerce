# Zipup – Full-Stack E-Commerce Web Application

Zipup is a full-stack MVC web application for streetwear apparel (Hoodies, Jackets, Tees, and Pants) featuring INR pricing. Built using Java 21, Jakarta Servlets, JSP, JDBC, and MySQL running on Apache Tomcat 10.1.

## Key Features
- **Authentication**: Secure user registration, login, and session tracking (`HttpSession`).
- **Catalog Management**: Dynamic apparel filtering across Hoodies, Jackets, Tees, and Pants.
- **E-Commerce Workflows**: Interactive Shopping Cart, Wishlist, and multi-step Order Checkout.
- **User Profile**: Personal account management and past order history.

## Tech Stack
- **Language**: Java 21
- **Backend Framework**: Jakarta Servlets (Tomcat 10.1)
- **Frontend**: JSP, HTML5, CSS3
- **Database**: MySQL (via JDBC DAO layer)
- **Architecture**: Model-View-Controller (MVC)

## Database Schema
The relational database `zipup_db` contains 6 normalized tables:
`users`, `products`, `cart`, `wishlist`, `orders`, and `order_items`.
