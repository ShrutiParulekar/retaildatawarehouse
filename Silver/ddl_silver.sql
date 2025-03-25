-- Assumes you are connected to the correct PostgreSQL database

-- DROP and CREATE tables within the 'bronze' schema
DROP TABLE IF EXISTS silver.orders;
CREATE TABLE silver.orders (
    order_id int,
    customer_id int,
    order_date TIMESTAMP,
    total_amount DECIMAL(10,2),
    discount DECIMAL(10,2),
    payment_method VARCHAR(50),
    order_status VARCHAR(255),
	dwh_create_date DATE DEFAULT CURRENT_DATE
);

DROP TABLE IF EXISTS silver.order_details;
CREATE TABLE silver.order_details (
    order_id INT,
    product_id VARCHAR(50),
    quantity INT,
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    total_revenue DECIMAL(10,2),
    profit DECIMAL(10,2)
);

DROP TABLE IF EXISTS silver.customers;
CREATE TABLE silver.customers (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(50),
    marital_status VARCHAR(20),
    country VARCHAR(50),
    signup_date DATE,
	dwh_create_date DATE DEFAULT CURRENT_DATE
);

DROP TABLE IF EXISTS silver.products;
CREATE TABLE silver.products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    release_date VARCHAR(50),
	dwh_create_date DATE DEFAULT CURRENT_DATE
);

DROP TABLE IF EXISTS silver.inventory;
CREATE TABLE silver.inventory (
    product_id INT,
    location_id INT,
    stock_level INT,
    last_stock_update TIMESTAMP,
	dwh_create_date DATE DEFAULT CURRENT_DATE
);
