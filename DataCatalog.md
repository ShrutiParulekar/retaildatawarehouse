# 📘 Gold Layer Data Catalog

This document outlines the structure of the **Gold Layer** in the Retail Sales Star Schema. It includes a detailed breakdown of all fact and dimension tables, their fields, data types, key designations, source tables, and descriptions.

---

## 🧱 `gold.fact_order_details` (Fact Table)

**Description:**  
Central fact table containing detailed transactional information for each order line item, including references to customers, products, and financial metrics like cost, revenue, and profit.

**Source Tables:** `orders`, `order_details`

**Primary Key:** (`order_id`, `product_id`)  
**Foreign Keys:** `order_id` → `dim_orders`, `product_id` → `dim_products`, `customer_id` → `dim_customers`

**Fields:**
- `order_id` (INT, FK)
- `customer_id` (INT, FK)
- `product_id` (INT, FK)
- `quantity` (FLOAT)
- `cost_price` (FLOAT)
- `selling_price` (FLOAT)
- `total_cost` (FLOAT)
- `total_revenue` (FLOAT)
- `profit` (FLOAT)

---

## 📘 `gold.dim_customers` (Dimension Table)

**Description:**  
Customer master data capturing personal information and demographic attributes to support customer segmentation and behavior analysis.

**Source Table:** `customers`  
**Primary Key:** `customer_id`

**Fields:**
- `customer_id` (INT, PK)
- `first_name` (STRING)
- `last_name` (STRING)
- `gender` (STRING)
- `marital_status` (STRING)
- `country` (STRING)
- `signup_date` (DATE)

---

## 📗 `gold.dim_products` (Dimension Table)

**Description:**  
Product reference data enriched with inventory details, used for product performance, category-level analytics, and stock availability.

**Source Tables:** `products`, `inventory`  
**Primary Key:** `product_id`

**Fields:**
- `product_id` (INT, PK)
- `product_name` (STRING)
- `category` (STRING)
- `cost_price` (FLOAT)
- `selling_price` (FLOAT)
- `release_date` (DATE)
- `stock_level` (FLOAT)
- `location_id` (INT)
- `last_stock_update` (DATE)

---

## 📙 `gold.dim_orders` (Dimension Table)

**Description:**  
Order-level metadata including customer reference, date of transaction, discounts, payment methods, and current order status.

**Source Table:** `orders`  
**Primary Key:** `order_id`  
**Foreign Key:** `customer_id` → `dim_customers`

**Fields:**
- `order_id` (INT, PK)
- `customer_id` (INT, FK)
- `order_date` (TIMESTAMP)
- `total_amount` (FLOAT)
- `discount` (INT)
- `payment_method` (STRING)
- `order_status` (STRING)

---
