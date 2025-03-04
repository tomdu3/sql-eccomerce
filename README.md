# E-Commerce Database Management System

This project involves creating a simple e-commerce database management system using MySQL. The system includes three main tables: `customers`, `orders`, and `products`. Below are the instructions to set up the database, define the table structures, and perform various SQL queries.

- Solution can be found in the file [ecommerce.sql](./ecommerce.sql).

---

## Instructions

### 1. Database Setup

1. Create a database named `ecommerce`.
2. Use the `ecommerce` database for all subsequent operations.

### 2. Table Structure

Create the following tables with the specified structure:

#### Customers Table

- `id`: Primary key, auto-increment (unique identifier for each customer).
- `name`: Customer's name.
- `email`: Customer's email address.
- `address`: Customer's address.

#### Orders Table

- `id`: Primary key, auto-increment (unique identifier for each order).
- `customer_id`: Foreign key referencing `customers.id` (the customer who placed the order).
- `order_date`: Date the order was placed.
- `total_amount`: Total amount of the order.

#### Products Table

- `id`: Primary key, auto-increment (unique identifier for each product).
- `name`: Product's name.
- `price`: Product's price.
- `description`: Product's description.

### 3. Sample Data Insertion

Insert sample data into the `customers`, `orders`, and `products` tables to populate the database.

### 4. SQL Queries

Write and execute the following queries:

1. Retrieve all customers who have placed an order in the last 30 days.
2. Get the total amount of all orders placed by each customer.
3. Update the price of `Product C` to `45.00`.
4. Add a new column `discount` to the `products` table.
5. Retrieve the top 3 products with the highest price.
6. Get the names of customers who have ordered `Product A`.
7. Join the `orders` and `customers` tables to retrieve the customer's name and order date for each order.
8. Retrieve the orders with a total amount greater than `150.00`.
9. Normalize the database by creating a separate table for `order_items` and updating the `orders` table to reference the `order_items` table.
10. Retrieve the average total of all orders.

### 5. Database Normalization

Normalize the database by creating a separate table for `order_items` to handle many-to-many relationships between orders and products.

---

**Note:** The complete SQL solution, including table creation, sample data insertion, and queries, is available in the file [ecommerce.sql](./ecommerce.sql).

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Copyright

Copyright © 2025 [TomDcoding]. All rights reserved.