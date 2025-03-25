-- Assumes you are connected to the correct PostgreSQL database

-- DROP and CREATE tables within the 'bronze' schema
DROP TABLE IF EXISTS bronze.orders;
CREATE TABLE bronze.orders (
    row_no INT,
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_date VARCHAR(50),
    total_amount VARCHAR(50),
    discount DECIMAL(10,2),
    payment_method VARCHAR(50),
    order_status VARCHAR(255)
);

DROP TABLE IF EXISTS bronze.order_details;
CREATE TABLE bronze.order_details (
    row_no INT,
    order_id INT,
    product_id INT,
    quantity INT,
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    total_revenue DECIMAL(10,2),
    profit DECIMAL(10,2)
);

DROP TABLE IF EXISTS bronze.customers;
CREATE TABLE bronze.customers (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(50),
    marital_status VARCHAR(20),
    country VARCHAR(50),
    signup_date VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.products;
CREATE TABLE bronze.products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    release_date VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.inventory;
CREATE TABLE bronze.inventory (
    product_id INT,
    location_id INT,
    stock_level INT,
    last_stock_update VARCHAR(50)
);
