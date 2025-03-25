DELIMITER $$

CREATE PROCEDURE load_bronze()
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    DECLARE sql_stmt VARCHAR(1000);
    
    -- Error handling
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        SELECT 'ERROR: Failed to load data into Bronze Layer' AS ErrorMessage;
    END;

    -- Start Execution Timer
    SET start_time = NOW();

    -- =========================================
    -- TRUNCATE BRONZE TABLES BEFORE LOADING
    -- =========================================
    TRUNCATE TABLE bronze.orders;
    TRUNCATE TABLE bronze.order_details;
    TRUNCATE TABLE bronze.customers;
    TRUNCATE TABLE bronze.products;
    TRUNCATE TABLE bronze.inventory;

    -- =========================================
    -- DYNAMIC LOAD DATA INFILE EXECUTION
    -- =========================================
    
    -- Orders Table
    SET @sql_stmt = CONCAT("LOAD DATA INFILE '/Users/shrutiparulekar/Desktop/PROJECTS/datawarehouse/Datasets/orders.csv' ",
                           "INTO TABLE bronze.orders ",
                           "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ",
                           "LINES TERMINATED BY '\\n' ",
                           "IGNORE 1 ROWS;");
    PREPARE stmt FROM @sql_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Order Details Table
    SET @sql_stmt = CONCAT("LOAD DATA INFILE '/Users/shrutiparulekar/Desktop/PROJECTS/datawarehouse/Datasets/order_details.csv' ",
                           "INTO TABLE bronze.order_details ",
                           "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ",
                           "LINES TERMINATED BY '\\n' ",
                           "IGNORE 1 ROWS;");
    PREPARE stmt FROM @sql_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Customers Table
    SET @sql_stmt = CONCAT("LOAD DATA INFILE '/Users/shrutiparulekar/Desktop/PROJECTS/datawarehouse/Datasets/customers.csv' ",
                           "INTO TABLE bronze.customers ",
                           "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ",
                           "LINES TERMINATED BY '\\n' ",
                           "IGNORE 1 ROWS;");
    PREPARE stmt FROM @sql_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Products Table
    SET @sql_stmt = CONCAT("LOAD DATA INFILE '/Users/shrutiparulekar/Desktop/PROJECTS/datawarehouse/Datasets/products.csv' ",
                           "INTO TABLE bronze.products ",
                           "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ",
                           "LINES TERMINATED BY '\\n' ",
                           "IGNORE 1 ROWS;");
    PREPARE stmt FROM @sql_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Inventory Table
    SET @sql_stmt = CONCAT("LOAD DATA INFILE '/Users/shrutiparulekar/Desktop/PROJECTS/datawarehouse/Datasets/inventory.csv' ",
                           "INTO TABLE bronze.inventory ",
                           "FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ",
                           "LINES TERMINATED BY '\\n' ",
                           "IGNORE 1 ROWS;");
    PREPARE stmt FROM @sql_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Capture End Time
    SET end_time = NOW();

    -- Print Execution Time
    SELECT 'Bronze Layer Load Completed' AS Status, 
           TIMESTAMPDIFF(SECOND, start_time, end_time) AS Load_Duration_Seconds;

END $$

DELIMITER ;
