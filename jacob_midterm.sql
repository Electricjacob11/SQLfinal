DROP DATABASE IF EXISTS game_store;
CREATE DATABASE game_store;
USE game_store;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(75) NOT NULL UNIQUE,
    phone_number CHAR(14) NOT NULL,
    street_address VARCHAR(100) NOT NULL,
    city VARCHAR(45) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    position VARCHAR(45) NOT NULL
);

CREATE TABLE games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(45) NOT NULL,
    platform VARCHAR(45) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    game_id INT NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) UNIQUE NOT NULL,
    phone CHAR(14) NOT NULL,
    email VARCHAR(75) NOT NULL
);

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    game_id INT NOT NULL,
    quantity INT NOT NULL,
    delivery_date DATE NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

-- Insert sample customers
INSERT INTO customers (first_name, last_name, email, phone_number, street_address, city, state, zip_code) VALUES
('John', 'Doe', 'johndoe@email.com', '(555)-123-4567', '123 Game St', 'Seattle', 'WA', '98101'),
('Jane', 'Smith', 'janesmith@email.com', '(555)-987-6543', '456 Console Ave', 'Portland', 'OR', '97202');

-- Insert sample employees
INSERT INTO employees (first_name, last_name, position) VALUES
('Alice', 'Brown', 'Manager'),
('Bob', 'Johnson', 'Sales Associate');

-- Insert sample games
INSERT INTO games (title, genre, platform, price, stock_quantity) VALUES
('The Last Quest', 'RPG', 'PC', 59.99, 10),
('Speed Racer X', 'Racing', 'Xbox', 39.99, 5);

-- Insert sample orders
INSERT INTO orders (customer_id, total_cost, order_date, employee_id) VALUES
(1, 59.99, '2025-02-20', 2),
(2, 39.99, '2025-02-19', 1);

-- Insert sample order details
INSERT INTO order_details (order_id, game_id, quantity, subtotal) VALUES
(1, 1, 1, 59.99),
(2, 2, 1, 39.99);

-- Insert sample suppliers
INSERT INTO suppliers (supplier_name, phone, email) VALUES
('GameWorld Distributors', '(555)-222-3333', 'contact@gameworld.com'),
('Best Game Supplies', '(555)-444-5555', 'support@bestgames.com');

-- Insert sample inventory
INSERT INTO inventory (supplier_id, game_id, quantity, delivery_date) VALUES
(1, 1, 20, '2025-02-15'),
(2, 2, 10, '2025-02-16');

SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM games;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM suppliers;
SELECT * FROM inventory;


select o.order_id, e.first_name from orders as o
natural join employees e;