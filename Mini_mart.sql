CREATE DATABASE mini_mart;
USE mini_mart;

CREATE TABLE Customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    customer_type VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (full_name, phone, address, customer_type) VALUES
('Nguyen Van A', '0901', 'Ha Noi', 'VIP'),
('Tran Thi B', '0902', 'Hai Phong', 'Normal'),
('Le Van C', '0903', 'Da Nang', 'VIP'),
('Pham Thi D', '0904', 'HCM', 'Normal'),
('Hoang Van E', '0905', 'Can Tho', 'Normal'),
('Do Thi F', '0906', 'Hue', 'Normal'),
('Vu Van G', '0907', 'Hai Duong', 'Normal');

INSERT INTO products (product_name, category, price, stock) VALUES
('Milk', 'Food', 20000, 50),
('Bread', 'Food', 15000, 30),
('Rice', 'Food', 18000, 100),
('Shampoo', 'Personal Care', 120000, 20),
('Soap', 'Personal Care', 25000, 0),
('Toothpaste', 'Personal Care', 30000, 40),
('Coca Cola', 'Drink', 10000, 60),
('Pepsi', 'Drink', 10000, 70),
('Orange Juice', 'Drink', 25000, 25),
('Water', 'Drink', 5000, 200);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2026-04-01', 'completed'),
(2, '2026-04-02', 'completed'),
(3, '2026-04-03', 'cancelled'),
(4, '2026-04-04', 'completed'),
(5, '2026-04-05', 'completed');

INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES
(1, 1, 2, 40000),
(1, 2, 1, 15000),
(2, 3, 3, 54000),
(2, 4, 1, 120000),
(3, 5, 2, 50000),
(3, 6, 1, 30000),
(4, 7, 5, 50000),
(4, 8, 2, 20000),
(4, 9, 1, 25000),
(5, 10, 10, 50000),
(5, 1, 3, 60000),
(5, 2, 2, 30000);

UPDATE products
SET stock = stock - 5
WHERE product_id = 1;

SELECT *
FROM products
WHERE category = 'Drink'
	AND price BETWEEN 10000 AND 50000
	AND stock > 0;
    
SELECT *
FROM customers
WHERE full_name LIKE 'Nguyen%' OR address = 'Ha Noi';

SELECT o.order_id, o.order_date, o.status, c.full_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

SELECT c.full_name, o.order_date, p.product_name, od.quantity, p.price AS unit_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id;

SELECT *
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT SUM(od.total_price) AS total_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
WHERE o.status = 'completed';

SELECT category, COUNT(*) AS total_products, AVG(price) AS avg_price
FROM products
GROUP BY category;

SELECT c.full_name, SUM(od.total_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name
HAVING SUM(od.total_price) > 500000;

SELECT *
FROM products
WHERE price > (
    SELECT AVG(price) FROM products
);

