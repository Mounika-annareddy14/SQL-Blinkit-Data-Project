/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

TRUNCATE TABLE silver.customers_info;
INSERT INTO silver.customers_info (
    customer_id,
    customer_name,
    email,
    phone,
    address,
    area,
    pincode,
    registration_date,
    customer_segment,
    total_orders,
    avg_order_value
)
SELECT
		CAST(customer_id AS INT),
		TRIM(customer_name) AS customer_name,
		TRIM(email) AS email,
		phone,
		TRIM(LEFT(address,255)),
		TRIM(area),
		CAST(pincode AS INT),
		TRY_CONVERT(DATE,registration_date,105),
		TRIM(customer_segment),
		CAST(total_orders AS INT),
		CAST(avg_order_value AS DECIMAL(10,2))
FROM bronze.customers_info
WHERE customer_id IS NOT NULL;


TRUNCATE TABLE silver.orders_info;
INSERT INTO silver.orders_info(
		order_id,
		customer_id,
		order_date,
		promised_delivery_time,
		actual_delivery_time,
		delivery_status,
		order_total,
		payment_method,
		delivery_partner_id,
		store_id)
SELECT
		CAST(order_id AS BIGINT),
		CAST(customer_id AS BIGINT),
		CONVERT(DATETIME,order_date,120),
		CONVERT(DATETIME,promised_delivery_time,120),
		CONVERT(DATETIME, actual_delivery_time,120),
		TRIM(delivery_status) AS delivery_status,
		CAST(order_total AS DECIMAL(10,2)),
		TRIM(payment_method) AS payment_method,
		CAST(delivery_partner_id AS INT),
		CAST(store_id AS INT)
FROM bronze.orders_info
WHERE order_id IS NOT NULL;


TRUNCATE TABLE silver.order_items_info;
INSERT INTO silver.order_items_info(
		order_id,
		product_id,
		quantity,
		unit_price)
SELECT 
		CAST(order_id as BIGINT),
		CAST(product_id as INT),
		CAST(quantity as INT),
		CAST(unit_price as DECIMAL(10,2))
FROM bronze.order_items_info
where order_id IS NOT NULL
