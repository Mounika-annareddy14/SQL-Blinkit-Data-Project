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

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '>>>>>>>>>><<<<<<<<<<<';
		PRINT 'SILVER Tables Data loading';
		PRINT '>>>>>>>>>>><<<<<<<<<<';
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
				TRIM(phone) AS phone,
				TRIM(LEFT(address,255)) AS address,
				TRIM(area) AS AREA,
				CAST(pincode AS INT),
				TRY_CONVERT(DATE,TRIM(registration_date),105),
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
				CONVERT(DATETIME,TRIM(order_date),120),
				CONVERT(DATETIME,TRIM(promised_delivery_time),120),
				CONVERT(DATETIME, TRIM(actual_delivery_time),120),
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


		TRUNCATE TABLE silver.products_info;
		INSERT INTO silver.products_info(
				product_id,
				product_name,
				category,
				brand,
				price,
				mrp,
				margin_percentage,
				shelf_life_days,
				min_stock_level,
				max_stock_level)
		SELECT
				CAST(product_id AS INT),
				TRIM(product_name) AS product_name,
				TRIM(category) AS category,
				TRIM(brand) AS brand,
				CAST(price AS DECIMAL(10,2)),
				CAST(mrp AS DECIMAL(10,2)),
				CAST(margin_percentage AS INT),
				CAST(shelf_life_days AS INT),
				CAST(min_stock_level AS INT),
				CAST(max_stock_level AS INT)
		FROM bronze.products_info
		WHERE product_id IS NOT NULL;


		TRUNCATE TABLE silver.inventory_info;
		INSERT INTO silver.inventory_info(
				product_id,
				inventory_date,
				stock_received,
				damaged_stock)
		SELECT 
				CAST(product_id AS INT),
				TRY_CONVERT(DATE,'01 ' + replace(inventory_date,'-',' '),6),
				CAST(stock_received AS INT),
				CAST(damaged_stock AS INT)
		FROM bronze.inventory_info
		WHERE product_id IS NOT NULL;

		TRUNCATE TABLE silver.delivery_performance_info;
		INSERT INTO silver.delivery_performance_info(
				order_id,
				delivery_partner_id,
				promised_time,
				actual_time,
				delivery_time_minutes,
				distance_km,
				delivery_status,
				reasons_if_delayed)
		SELECT 
				CAST(order_id AS BIGINT),
				CAST(delivery_partner_id AS INT),
				CONVERT(DATETIME, TRIM(promised_time),120),
				CONVERT(DATETIME, TRIM(actual_time),120),
				CAST(CAST(delivery_time_minutes AS DECIMAL(10,1)) AS INT),
				CAST(distance_km AS DECIMAL(10,2)),
				TRIM(delivery_status) AS delivery_status,
				CASE 
						WHEN reasons_if_delayed IS NULL THEN 'Not applicable'
						ELSE TRIM(reasons_if_delayed)
				END
		FROM bronze.delivery_performance_info
		WHERE order_id IS NOT NULL;



		TRUNCATE TABLE silver.marketing_performance_info;
		INSERT INTO silver.marketing_performance_info(
				campaign_id,
				campaign_name,
				campaign_date,
				target_audience,
				channel,
				impressions,
				clicks,
				conversions,
				spend,
				revenue_generated,
				roas)
		SELECT
				CAST(campaign_id AS INT),
				TRIM(campaign_name),
				TRY_CONVERT(DATE, campaign_date),
				TRIM(target_audience),
				TRIM(channel),
				CAST(impressions AS INT),
				CAST(clicks AS INT),
				CAST(conversions AS INT),
				CAST(spend AS DECIMAL(10,2)),
				CAST(revenue_generated AS DECIMAL(10,2)),
				CAST(roas AS DECIMAL(10,2))
		FROM bronze.marketing_performance_info
		WHERE campaign_id IS NOT NULL;

		TRUNCATE TABLE silver.customer_feedback_info;
		INSERT INTO silver.customer_feedback_info(
				feedback_id,
				order_id,
				customer_id,
				rating,
				feedback_text,
				feedback_category,
				sentiment,
				feedback_date)
		SELECT
				CAST(feedback_id AS INT),
				CAST(order_id AS BIGINT),
				CAST(customer_id AS INT),
				CAST(rating AS INT),
				TRIM(feedback_text),
				TRIM(feedback_category),
				TRIM(sentiment),
				TRY_CONVERT(DATE, feedback_date,105)
		FROM bronze.customer_feedback_info
		WHERE feedback_id IS NOT NULL;


		TRUNCATE TABLE silver.category_icons_info;
		INSERT INTO silver.category_icons_info(
				category,
				Image_link)
		SELECT
				TRIM(category),
				TRIM(Image_link)
		FROM bronze.category_icons_info
		WHERE category IS NOT NULL;

		TRUNCATE TABLE silver.rating_icons_info;
		INSERT INTO silver.rating_icons_info(
				Rating,
				Emoji,
				Star)
		SELECT 
				CAST(Rating AS INT),
				TRIM(Emoji),
				TRIM(Star)
		FROM bronze.rating_icons_info
		WHERE Rating IS NOT NULL;
		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER';
		PRINT 'ERROR MESSAGE' + error_message();
		PRINT 'ERROR NUMBER' + error_number();
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	END CATCH
END

UPDATE silver.delivery_performance_info
SET delivery_time_minutes =
    CASE
        WHEN actual_time <= promised_time THEN 0
        ELSE DATEDIFF(MINUTE, promised_time, actual_time)
    END;



UPDATE silver.delivery_performance_info
SET delivery_status =
    CASE
        WHEN actual_time <= promised_time THEN 'On Time'
        WHEN DATEDIFF(MINUTE, promised_time, actual_time) <= 10 THEN 'Slightly Delayed'
        ELSE 'Significantly Delayed'
    END;

UPDATE silver.delivery_performance_info
SET reasons_if_delayed = 'Not Applicable'
WHERE delivery_status = 'On Time';

--select * from bronze.rating_icons_info;

--select * from silver.customers_info;
--select * from silver.orders_info;
--select * from silver.order_items_info;
--select * from silver.products_info;
--select * from silver.inventory_info;
--select * from silver.delivery_performance_info;
--select * from silver.marketing_performance_info;
--select * from silver.customer_feedback_info;
--select * from silver.category_icons_info;
--select * from silver.rating_icons_info
