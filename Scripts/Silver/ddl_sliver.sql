/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
USE Blinkit_Dwh;
Go

IF OBJECT_ID('silver.customers_info' ,'U') IS NOT NULL
			DROP TABLE silver.customers_info;
GO

CREATE TABLE silver.customers_info (
			customer_id INT,
			customer_name VARCHAR(50),
			email VARCHAR(100),
			phone VARCHAR(20),
			address NVARCHAR(255),
			area VARCHAR(100),
			pincode VARCHAR(10),
			registration_date DATE,
			customer_segment VARCHAR(50),
			total_orders INT,
			avg_order_value DECIMAL(10,2),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);

IF OBJECT_ID('silver.orders_info' ,'U') IS NOT NULL
			DROP TABLE silver.orders_info;
GO

CREATE TABLE silver.orders_info(
			order_id BIGINT,
			customer_id BIGINT,
			order_date DATETIME,
			promised_delivery_time DATETIME,
			actual_delivery_time DATETIME,
			delivery_status VARCHAR(50),
			order_total DECIMAL(10,2),
			payment_method VARCHAR(50),
			delivery_partner_id INT,
			store_id INT,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);

IF OBJECT_ID('silver.order_items_info' ,'U') IS NOT NULL
			DROP TABLE silver.order_items_info;
GO
CREATE TABLE silver.order_items_info(
			order_id BIGINT,
			product_id INT,
			quantity INT,
			unit_price DECIMAL(10,2),
			dwh_create_date DATETIME2 DEFAULT GETDATE()	
			);

IF OBJECT_ID('silver.products_info' ,'U') IS NOT NULL
			DROP TABLE silver.products_info;
GO
CREATE TABLE silver.products_info(
			product_id INT,
			product_name VARCHAR(150),
			category VARCHAR(50),
			brand NVARCHAR(255),
			price DECIMAL(10,2),
			mrp DECIMAL(10,2),
			margin_percentage INT,
			shelf_life_days INT,
			min_stock_level INT,
			max_stock_level INT,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);

IF OBJECT_ID('silver.inventory_info' ,'U') IS NOT NULL
			DROP TABLE silver.inventory_info;
GO
CREATE TABLE silver.inventory_info(
			product_id INT,
			inventory_date DATE,
			stock_received INT,
			damaged_stock INT,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);

IF OBJECT_ID('silver.delivery_performance_info' ,'U') IS NOT NULL
	DROP TABLE silver.delivery_performance_info;
GO
CREATE TABLE silver.delivery_performance_info(
			order_id BIGINT,
			delivery_partner_id INT,
			promised_time DATETIME,
			actual_time DATETIME,
			delivery_time_minutes INT,
			distance_km DECIMAL(10,2),
			delivery_status VARCHAR(50),
			reasons_if_delayed VARCHAR(255),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);

IF OBJECT_ID('silver.marketing_performance_info' ,'U') IS NOT NULL
			DROP TABLE silver.marketing_performance_info;
GO
CREATE TABLE silver.marketing_performance_info(
			campaign_id INT,
			campaign_name VARCHAR(100),
			campaign_date DATE,
			target_audience VARCHAR(50),
			channel VARCHAR(50),
			impressions INT,
			clicks INT,
			conversions INT,
			spend DECIMAL(10,2),
			revenue_generated DECIMAL(10,2),
			roas DECIMAL(10,2),
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			);

IF OBJECT_ID('silver.customer_feedback_info' ,'U') IS NOT NULL
			DROP TABLE silver.customer_feedback_info;
GO
CREATE TABLE silver.customer_feedback_info(
			feedback_id INT,
			order_id BIGINT,
			customer_id INT,
			rating INT,
			feedback_text NVARCHAR(MAX),
			feedback_category VARCHAR(50),
			sentiment VARCHAR(50),
			feedback_date DATE,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
		);

IF OBJECT_ID('silver.category_icons_info' ,'U') IS NOT NULL
			DROP TABLE silver.category_icons_info;
GO
CREATE TABLE silver.category_icons_info(
			category VARCHAR(50),
			Image_link NVARCHAR(max)
		);

IF OBJECT_ID('silver.rating_icons_info' ,'U') IS NOT NULL
			DROP TABLE silver.rating_icons_info;
GO
CREATE TABLE silver.rating_icons_info(
			Rating INT,
			Emoji NVARCHAR(50),
			Star VARCHAR(50)
		);
