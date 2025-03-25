

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
    END AS first_name,

    CASE 
        WHEN upper(trim(last_name)) IS NULL OR upper(trim(last_name)) = 'N/A' THEN 'N/A'
        WHEN last_name != trim(last_name) THEN 'N/A'
        ELSE trim(last_name) 
    END AS last_name,

    CASE 
        WHEN upper(gender) = 'F' THEN 'Female'
        WHEN upper(gender) = 'M' THEN 'Male'
        WHEN gender IS NULL THEN 'N/A'
        ELSE gender 
    END AS gender,

    CASE 
        WHEN marital_status IS NULL THEN 'N/A'
        ELSE marital_status 
    END AS marital_status,

    CASE 
        WHEN trim(lower(country)) = 'uk' THEN 'UK'
        WHEN trim(lower(country)) = 'india' THEN 'India'
        WHEN trim(lower(country)) = 'germany' THEN 'Germany'
        WHEN trim(lower(country)) = 'usa' THEN 'USA'
        WHEN trim(lower(country)) = 'france' THEN 'France'
        WHEN country IS NULL THEN 'N/A'
        ELSE country 
    END AS country,
	CAST(signup_date AS DATE) AS signup_date


FROM bronze.customers
;






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
    ) AS stock_level,
    
    COALESCE(
        CASE 
            WHEN last_stock_update = '31/02/2023' THEN NULL
            WHEN last_stock_update = '13-13-2023' THEN NULL
            WHEN last_stock_update ~* '[a-z]' THEN NULL
            ELSE TO_TIMESTAMP(last_stock_update, 'YYYY-MM-DD')
        END,
        TO_TIMESTAMP('1900-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
    ) AS last_stock_update

FROM bronze.inventory;



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
SELECT order_id,
    CASE 
        WHEN product_id IS NULL OR TRIM(UPPER(product_id)) IN ('', 'N/A') THEN '-1'
        WHEN product_id LIKE '%prod%' THEN 
            SPLIT_PART(product_id , '_', 2)
		WHEN length(product_id) > 4 then '-1'
        ELSE 
            product_id
    END AS product_id,
 CASE 
        WHEN quantity IS NULL or quantity::numeric = -1 
             AND total_revenue IS NOT NULL 
             AND selling_price IS NOT NULL 
             AND selling_price::NUMERIC != 0 
        THEN ROUND(total_revenue::NUMERIC / selling_price::NUMERIC, 2)
        ELSE quantity::NUMERIC
    END AS quantity,
	 
COALESCE(cost_price,0) AS cost_price,

COALESCE(selling_price, 0) AS selling_price,
COALESCE(total_cost, 0) as total_cost,
case when (profit!= (selling_price - cost_price) * quantity:: float)
          or profit is null 
	 then (COALESCE(selling_price, 0) - COALESCE(total_cost, 0)) * quantity:: float
	 else profit
end as profit,
total_revenue
FROM bronze.order_details;




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
    order_id::int, 
    customer_id::int,
    
    COALESCE(
      CASE 
        WHEN TRIM(UPPER(order_date)) IN ('', 'NULL', 'N/A') THEN NULL
        ELSE order_date::TIMESTAMP
      END,
      TIMESTAMP '1900-01-01 00:00:00'
    ) AS order_date,

    total_amount::numeric,
    discount,

    CASE 
        WHEN payment_method IS NULL THEN 'N/A' 
        ELSE payment_method 
    END AS payment_method,

    CASE 
        WHEN order_status ILIKE 'co%' THEN 'Completed'
        WHEN order_status IS NULL THEN 'N/A'
        ELSE order_status
    END AS order_status

FROM bronze.orders;





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
    END AS category,

    COALESCE(cost_price::DECIMAL(10,2), 0) AS cost_price,
    selling_price::DECIMAL(10,2) AS selling_price,

    COALESCE(
        CASE 
            WHEN release_date ILIKE 'N%' OR TRIM(release_date) = '' THEN NULL
            ELSE release_date::TIMESTAMP
        END,
        TIMESTAMP '1900-01-01 00:00:00'
    ) AS release_date

FROM bronze.products;




