create database E_commerce;

use E_commerce;

show tables;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers VALUES
(1, 'Amit Kumar', 'amit@example.com', 'Mumbai'),
(2, 'Sana Ali', 'sana@example.com', 'Delhi'),
(3, 'Rohit Sharma', 'rohit@example.com', 'Mumbai'),
(4, 'Priya Singh', 'priya@example.com', 'Chennai'),
(5, 'John Mathew', 'john@example.com', 'Bangalore');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Smartphone', 'Electronics', 25000),
(3, 'Headphones', 'Accessories', 2000),
(4, 'Office Chair', 'Furniture', 7000),
(5, 'Keyboard', 'Accessories', 1200);

INSERT INTO orders VALUES
(101, 1, '2024-01-10'),
(102, 2, '2024-01-12'),
(103, 1, '2024-02-01'),
(104, 3, '2024-02-05'),
(105, 5, '2024-03-01');

INSERT INTO order_items VALUES
(1, 101, 1, 1),
(2, 101, 3, 2),
(3, 102, 2, 1),
(4, 103, 4, 1),
(5, 103, 5, 3),
(6, 104, 3, 1),
(7, 105, 1, 1);


/* ============================================================
   3. REQUIRED ANALYSIS QUERIES
   ============================================================ */

/* ---------------------------
   A. BASIC SELECT / WHERE / ORDER BY
   --------------------------- */

-- 1. Get all customers from Mumbai
SELECT * FROM customers
WHERE city = 'Mumbai';

-- 2. List all products ordered by price descending
SELECT * FROM products
ORDER BY price DESC;


/* ---------------------------
   B. GROUP BY + AGGREGATE FUNCTIONS
   --------------------------- */

-- 3. Total number of orders by each customer
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 4. Average price of products by category
SELECT category, AVG(price) AS avg_price
FROM products
GROUP BY category;


/* ---------------------------
   C. JOINS (INNER / LEFT)
   --------------------------- */

-- 5. Show order details with customer, product, and quantity
SELECT o.order_id, c.name, p.product_name, oi.quantity
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON oi.product_id = p.product_id;

-- 6. List customers who have never placed any order
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


/* ---------------------------
   D. SUBQUERIES
   --------------------------- */

-- 7. Find products priced above average
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 8. Find customers who bought more than 5 items total
SELECT name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
    HAVING SUM(oi.quantity) > 5
);


/* ---------------------------
   E. CREATE VIEWS
   --------------------------- */

-- 9. Create customer purchase summary view
CREATE VIEW customer_purchase_summary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * p.price) AS total_amount_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id;

-- 10. Query the view
SELECT * FROM customer_purchase_summary;


/* ---------------------------
   F. INDEX OPTIMIZATION
   --------------------------- */

-- 11. Create indexes for performance
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_item_product ON order_items(product_id);
CREATE INDEX idx_product_category ON products(category);

