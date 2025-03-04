-- Task:
-- Create a database and tables to manage a simple e-commerce system. 
-- The system should have three tables: customers, orders, and products.

-- Requirements:
-- Create a database named ecommerce.

CREATE DATABASE ecommerce;
USE ecommerce;

-- Create three tables: customers, orders, and products.
-- Table Structure:

-- Create customers table
-- id (primary key, auto-increment): unique identifier for each customer
-- name: customer's name
-- email: customer's email address
-- address: customer's address
CREATE TABLE customers (
	id INT auto_increment PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL
);

-- Check creation of the table
SELECT * FROM customers;

-- Create orders table
-- id (primary key, auto-increment): unique identifier for each order
-- customer_id (foreign key referencing customers.id): a customer who placed the order
-- order_date: date the order was placed
-- total_amount: total amount of the order

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)  -- One-to-Many relationship
);

-- Check creation of the orders table
SELECT * FROM orders;

-- products table
-- id (primary key, auto-increment): unique identifier for each product
-- name: product's name
-- price: product's price
-- description: product's description
CREATE TABLE products (
	id INT auto_increment PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- check table creation
SELECT * FROM products;

-- Insert some sample data into the customers table.

INSERT INTO customers (name, email, address) VALUES
('captain_america', 'cap@example.com', '123 Liberty Ave'),
('thor', 'thor@example.com', 'Asgard'),
('hulk', 'hulk@example.com', 'Bruce Banner Laboratory'),
('black_panther', 'bp@example.com', 'Wakanda Forever'),
('dr_strange', 'strange@example.com', 'Kamar-Taj'),
('aquaman', 'aquaman@example.com', 'Atlantis'),
('wonder_woman', 'ww@example.com', 'Themyscira'),
('flash', 'flash@example.com', 'Central City'),
('green_lantern', 'gl@example.com', 'Oa'),
('batman', 'batman@example.com', 'Gotham City');

-- Insert sample data into products table
INSERT INTO products (name, price, description) VALUES
('Product A', 99.99, 'Legendary hammer of Thor.'),
('Product B', 199.99, 'Powerful artifact used by Loki.'),
('Product C', 299.99, 'Expand your size with Hulk Fists.'),
('Product D', 299.99, 'Vibranium suit designed for stealth and strength.'),
('Product E', 499.99, 'Allows control over time.'),
('Product F', 999.99, 'Ultimate weapon for the universe.'),
('Product G', 39.99, 'Miniature Groot for collectors.'),
('Product H', 399.99, 'High-tech aircraft used by Batman.'),
('Product I', 29.99, 'Batman\'s iconic weapon.'),
('Product J', 49.99, 'Collectible joker figurine.'),
('Product K', 59.99, 'Lasso of Truth for heroic deeds.'),
('Product L', 199.99, 'The power of will, contained in a ring.'),
('Product M', 149.99, 'Designed to harness the Speed Force.'),
('Product N', 299.99, 'Authentic suit for web-swinging adventures.'),
('Product O', 249.99, 'Indestructible shield of Cap.');

-- Insert sample data into the orders table
SET @date = NOW();  -- start date for orders , we will use date subtraction to easily make different dates for the table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, DATE_SUB(@date, INTERVAL 50 DAY), 59.98),  -- captain_america
(2, DATE_SUB(@date, INTERVAL 40 DAY), 199.99), -- thor
(3, DATE_SUB(@date, INTERVAL 30 DAY), 1200.00),-- hulk
(4, DATE_SUB(@date, INTERVAL 20 DAY), 99.99),  -- black_panther
(5, DATE_SUB(@date, INTERVAL 10 DAY), 199.99),  -- dr_strange
(6, DATE_SUB(@date, INTERVAL 5 DAY), 299.99),  -- aquaman
(7, DATE_SUB(@date, INTERVAL 4 DAY), 299.99),  -- wonder_woman
(8, DATE_SUB(@date, INTERVAL 55 DAY), 499.99),  -- flash
(9, DATE_SUB(@date, INTERVAL 2 DAY), 39.99),  -- green_lantern
(10, DATE_SUB(@date, INTERVAL 1 DAY), 999.99),  -- batman
(1, DATE_SUB(@date, INTERVAL 36 DAY), 59.99),  -- captain_america
(2, DATE_SUB(@date, INTERVAL 35 DAY), 199.99),  -- thor
(3, DATE_SUB(@date, INTERVAL 13 DAY), 1200.00),  -- hulk
(4, DATE_SUB(@date, INTERVAL 14 DAY), 99.99),  -- black_panther
(5, DATE_SUB(@date, INTERVAL 15 DAY), 199.99),  -- dr_strange
(6, DATE_SUB(@date, INTERVAL 16 DAY), 299.99),  -- aquaman
(7, DATE_SUB(@date, INTERVAL 17 DAY), 299.99),  -- wonder_woman
(8, DATE_SUB(@date, INTERVAL 31 DAY), 499.99),  -- flash
(9, DATE_SUB(@date, INTERVAL 19 DAY), 39.99),  -- green_lantern
(10, DATE_SUB(@date, INTERVAL 20 DAY), 999.99);  -- batman

-- Check inserted data
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

-- QUERIES

-- 1. Retrieve all customers who have placed an order in the last 30 days.
SELECT * FROM customers
WHERE id IN (
	SELECT DISTINCT customer_id
    FROM orders
    WHERE order_date>=NOW() - INTERVAL 30 DAY
);

-- 2. Get the total amount of all orders placed by each customer.
SELECT customer_id, SUM(total_amount) as total_order_amount
FROM orders 
GROUP BY customer_id;

-- 3. Update the price of Product C to 45.00.
SELECT * FROM products;

-- the following query didn't work on MySQL Workbench, though it worked fine in MySQL cli
-- UPDATE products
-- SET price=45.00
-- WHERE name='Product C';

-- check
SELECT * FROM products WHERE name='Product C';

-- this worked by using ID
UPDATE products
SET price=45.00
WHERE id=3;

-- I looked a bit on the internet and found a solution to this
CREATE INDEX idx_name ON products(name);  -- creates an index on the name column, making lookups faster and more efficient
UPDATE products
SET price = 45.00
WHERE name = 'Product C';

 -- check if the change was successful
SELECT * FROM products
WHERE name='Product C';  -- now it works

-- 4. Add a new column discount to the products table.
ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;

-- check updated table
SELECT * FROM products;

-- 5. Retrieve the top 3 products with the highest price.
SELECT * FROM products
ORDER BY price DESC LIMIT 3;

-- 6. Get the names of customers who have ordered Product A.
-- this cannot be done in the actual configuration of the table. We didn't connect orders and products table.
-- The only way is that I can try to see if the product price matches the total_amount of the order
SELECT DISTINCT c.name  -- we use DISTINCT in case the customer ordered the product multiple times
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN products p ON o.total_amount = p.price
WHERE p.name = 'Product A';

-- 7. Join the orders and customers tables to retrieve the customer's name and order date for each order.
SELECT c.name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.id;
 
-- 8. Retrieve the orders with a total amount greater than 150.00.
SELECT *
FROM orders
WHERE total_amount > 150.00;

-- 9. Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.
-- Create order_items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,  -- I also added quantity as a logical thing for ecommerce
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Update orders table to remove total_amount
ALTER TABLE orders
DROP COLUMN total_amount;

-- Insert sample data into order_items (I added more comments for each order so it could be understood easily)
INSERT INTO order_items (order_id, product_id, quantity) VALUES
-- Order 1: captain_america
(1, 1, 1),  -- Product A
(1, 15, 1),  -- Product O
-- Order 2: thor
(2, 2, 1),  -- Product B
-- Order 3: hulk
(3, 3, 4),  -- Product C (4 units)
-- Order 4: black_panther
(4, 4, 1),  -- Product D
-- Order 5: dr_strange
(5, 5, 1),  -- Product E
-- Order 6: aquaman
(6, 6, 1),  -- Product F
-- Order 7: wonder_woman
(7, 11, 1),  -- Product K
-- Order 8: flash
(8, 13, 1),  -- Product M
-- Order 9: green_lantern
(9, 12, 1),  -- Product L
-- Order 10: batman
(10, 8, 1),  -- Product H
-- Order 11: captain_america
(11, 1, 1),  -- Product A
-- Order 12: thor
(12, 2, 1),  -- Product B
-- Order 13: hulk
(13, 1, 4),  -- Product A (4 units)
-- Order 14: black_panther
(14, 4, 1),  -- Product D
-- Order 15: dr_strange
(15, 5, 1),  -- Product E
-- Order 16: aquaman
(16, 6, 1),  -- Product F
-- Order 17: wonder_woman
(17, 11, 1),  -- Product K
-- Order 18: flash
(18, 13, 1),  -- Product M
-- Order 19: green_lantern
(19, 12, 1),  -- Product L
-- Order 20: batman
(20, 8, 1);  -- Product H

-- Check order_items table
SELECT * FROM order_items;

-- Check orders table
SELECT * FROM orders;

-- Check products table
SELECT * FROM products;

-- Check customers table
SELECT * FROM customers;

-- 10. Retrieve the average total of all orders.
/* This would be a solution if we didn't change the orders table
SELECT AVG(total_amount) AS average_order_total
FROM orders; **/

-- Let us first get the list of totals of all orders
SELECT o.id AS order_id, SUM(oi.quantity * p.price) AS order_total  -- Calculate total amount for each order
    FROM orders o  -- Select from orders table
    JOIN order_items oi ON o.id = oi.order_id  -- Join with order_items table on order_id
    JOIN products p ON oi.product_id = p.id  -- Join with products table on product_id
    GROUP BY o.id;  -- group by order id

-- Let us use that as an inner query to calculate the average
SELECT AVG(order_total) AS average_order_total
FROM (
    SELECT o.id AS order_id, SUM(oi.quantity * p.price) AS order_total  
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
    GROUP BY o.id
) AS order_totals;  -- Use the result as a subquery for the outer query

-- Additional query. Now we can easily get a query No. 6
-- Second solution: Query 6. Get the names of customers who have ordered Product A.
SELECT DISTINCT c.name  -- Use DISTINCT to avoid duplicates, in case a customer ordered multiple times
FROM customers c
JOIN orders o ON c.id = o.customer_id  -- Join customers with orders
JOIN order_items oi ON o.id = oi.order_id  -- Join orders with order items
JOIN products p ON oi.product_id = p.id  -- Join order items with products
WHERE p.name = 'Product A';  -- Filter to only include orders for Product A