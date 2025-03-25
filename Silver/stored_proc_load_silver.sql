CREATE OR REPLACE PROCEDURE load_silver_data()
LANGUAGE plpgsql
AS $$
BEGIN

  -- Clear silver.customers
  TRUNCATE TABLE silver.customers;

  INSERT INTO silver.customers (
      customer_id,
      first_name,
      last_name,
      gender,
      marital_status,
      country,
      signup_date
  )
  SELECT 
      customer_id, 
      CASE 
          WHEN upper(trim(first_name)) IS NULL OR upper(trim(first_name)) = 'N/A' THEN 'N/A'
          WHEN first_name != trim(first_name) THEN 'N/A'
          ELSE trim(first_name) 
      END,
      CASE 
          WHEN upper(trim(last_name)) IS NULL OR upper(trim(last_name)) = 'N/A' THEN 'N/A'
          WHEN last_name != trim(last_name) THEN 'N/A'
          ELSE trim(last_name) 
      END,
      CASE 
          WHEN upper(gender) = 'F' THEN 'Female'
          WHEN upper(gender) = 'M' THEN 'Male'
          WHEN gender IS NULL THEN 'N/A'
          ELSE gender 
      END,
      CASE 
          WHEN marital_status IS NULL THEN 'N/A'
          ELSE marital_status 
      END,
      CASE 
          WHEN trim(lower(country)) = 'uk' THEN 'UK'
          WHEN trim(lower(country)) = 'india' THEN 'India'
          WHEN trim(lower(country)) = 'germany' THEN 'Germany'
          WHEN trim(lower(country)) = 'usa' THEN 'USA'
          WHEN trim(lower(country)) = 'france' THEN 'France'
          WHEN country IS NULL THEN 'N/A'
          ELSE country 
      END,
      CAST(signup_date AS DATE)
  FROM bronze.customers;

  -- Clear silver.inventory
  TRUNCATE TABLE silver.inventory;

  INSERT INTO silver.inventory (
      product_id,
      location_id,
      stock_level,
      last_stock_update
  )
  SELECT 
      CAST(product_id AS INT),
      CAST(location_id AS INT),
      COALESCE(
          CASE 
              WHEN TRIM(UPPER(stock_level)) IN ('N/A', '') THEN NULL
              ELSE stock_level::INT
          END,
          0
      ),
      COALESCE(
          CASE 
              WHEN last_stock_update = '31/02/2023' THEN NULL
              WHEN last_stock_update = '13-13-2023' THEN NULL
              WHEN last_stock_update ~* '[a-z]' THEN NULL
              ELSE TO_TIMESTAMP(last_stock_update, 'YYYY-MM-DD')
          END,
          TO_TIMESTAMP('1900-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
      )
  FROM bronze.inventory;

  -- Clear silver.order_details
  TRUNCATE TABLE silver.order_details;

  INSERT INTO silver.order_details (
      order_id,
      product_id,
      quantity,
      cost_price,
      selling_price,
      total_cost,
      total_revenue,
      profit
  )
  SELECT 
      order_id,
      CASE 
          WHEN product_id IS NULL OR TRIM(UPPER(product_id)) IN ('', 'N/A') THEN -1
          WHEN product_id LIKE '%prod%' THEN CAST(SPLIT_PART(product_id , '_', 2) AS INT)
          WHEN LENGTH(product_id) > 4 THEN -1
          ELSE CAST(product_id AS INT)
      END,
      CASE 
          WHEN quantity IS NULL OR quantity::NUMERIC = -1 
               AND total_revenue IS NOT NULL 
               AND selling_price IS NOT NULL 
               AND selling_price::NUMERIC != 0 
          THEN ROUND(total_revenue::NUMERIC / selling_price::NUMERIC, 2)
          ELSE quantity::NUMERIC
      END,
      COALESCE(cost_price::DECIMAL(10,2), 0),
      COALESCE(selling_price::DECIMAL(10,2), 0),
      COALESCE(total_cost::DECIMAL(10,2), 0),
      total_revenue,
      CASE 
          WHEN profit IS NULL 
               OR profit != (selling_price - cost_price) * quantity::FLOAT
          THEN (COALESCE(selling_price, 0) - COALESCE(total_cost, 0)) * quantity::FLOAT
          ELSE profit
      END
  FROM bronze.order_details;

  -- Clear silver.orders
  TRUNCATE TABLE silver.orders;

  INSERT INTO silver.orders (
      order_id,
      customer_id,
      order_date,
      total_amount,
      discount,
      payment_method,
      order_status
  )
  SELECT 
      order_id::INT, 
      customer_id::INT,
      COALESCE(
          CASE 
              WHEN TRIM(UPPER(order_date)) IN ('', 'NULL', 'N/A') THEN NULL
              ELSE order_date::TIMESTAMP
          END,
          TIMESTAMP '1900-01-01 00:00:00'
      ),
      total_amount::NUMERIC,
      discount,
      COALESCE(payment_method, 'N/A'),
      CASE 
          WHEN order_status ILIKE 'co%' THEN 'Completed'
          WHEN order_status IS NULL THEN 'N/A'
          ELSE order_status
      END
  FROM bronze.orders;

  -- Clear silver.products
  TRUNCATE TABLE silver.products;

  INSERT INTO silver.products (
      product_id,
      product_name,
      category,
      cost_price,
      selling_price,
      release_date
  )
  SELECT 
      product_id, 
      product_name,
      CASE 
          WHEN UPPER(TRIM(category)) ILIKE 'ACC%' THEN 'Accessories'
          WHEN UPPER(TRIM(category)) ILIKE 'ELE%' THEN 'Electronics'
          WHEN UPPER(TRIM(category)) ILIKE 'WE%' THEN 'Wearables'
          WHEN category IS NULL OR UPPER(TRIM(category)) = 'UNKNOWN' THEN 'N/A'
          ELSE category 
      END,
      COALESCE(cost_price::DECIMAL(10,2), 0),
      selling_price::DECIMAL(10,2),
      COALESCE(
          CASE 
              WHEN release_date ILIKE 'N%' OR TRIM(release_date) = '' THEN NULL
              ELSE release_date::TIMESTAMP
          END,
          TIMESTAMP '1900-01-01 00:00:00'
      )
  FROM bronze.products;

END;
$$;

CALL load_silver_data();

