
CREATE OR REPLACE PROCEDURE create_gold_layer_views()
LANGUAGE SQL
AS
$$
-- Fact Table: Order Details with Customer ID
CREATE OR REPLACE VIEW gold.fact_order_details AS
SELECT
  od.order_id,
  o.customer_id,
  od.product_id,
  od.quantity,
  od.cost_price,
  od.selling_price,
  od.total_cost,
  od.total_revenue,
  od.profit
FROM silver.order_details od
JOIN silver.orders o ON od.order_id = o.order_id;

-- Dimension Table: Customers
CREATE OR REPLACE VIEW gold.dim_customers AS
SELECT DISTINCT
  customer_id,
  first_name,
  last_name,
  gender,
  marital_status,
  country,
  signup_date
FROM silver.customers;

-- Dimension Table: Products with Inventory
CREATE OR REPLACE VIEW gold.dim_products AS
SELECT DISTINCT
  p.product_id,
  p.product_name,
  p.category,
  p.cost_price,
  p.selling_price,
  p.release_date,
  i.stock_level,
  i.location_id,
  i.last_stock_update
FROM silver.products p
LEFT JOIN silver.inventory i ON p.product_id = i.product_id;

-- Dimension Table: Orders
CREATE OR REPLACE VIEW gold.dim_orders AS
SELECT DISTINCT
  order_id,
  customer_id,
  order_date,
  total_amount,
  discount,
  payment_method,
  order_status
FROM silver.orders;
$$;

call create_gold_layer_views();

