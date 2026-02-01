/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

use Blinkit_Dwh;

if OBJECT_ID('bronze.customers_info','U') is not null
	drop table bronze.customers_info;
go

create table bronze.customers_info (
customer_id INT,
customer_name varchar(50),
email varchar(50),
phone varchar(50),
address varchar(50),
area varchar(50),
pincode varchar(50),
registration_date varchar(50),
customer_segment varchar(50),
total_orders varchar(50),
avg_order_value varchar(50)
);


if OBJECT_ID('bronze.orders_info','U') is not null
		drop table bronze.orders_info;
go
CREATE TABLE bronze.orders_info (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_date VARCHAR(50),
    promised_delivery_time VARCHAR(50),
    actual_delivery_time VARCHAR(50),
    delivery_status VARCHAR(100),
    order_total VARCHAR(50),
    payment_method VARCHAR(100),
    delivery_partner_id VARCHAR(50),
    store_id VARCHAR(50)
);


if OBJECT_ID('bronze.order_items_info','U') is not null
		drop table bronze.order_items_info;
go
CREATE TABLE bronze.order_items_info (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity VARCHAR(50),
    unit_price VARCHAR(50)
);

if OBJECT_ID('bronze.products_info','U') is not null
		drop table bronze.products_info;
go
CREATE TABLE bronze.products_info (
    product_id VARCHAR(50),
    product_name VARCHAR(200),
    category VARCHAR(100),
    brand VARCHAR(100),
    price VARCHAR(50),
    mrp VARCHAR(50),
    margin_percentage VARCHAR(50),
    shelf_life_days VARCHAR(50),
    min_stock_level VARCHAR(50),
    max_stock_level VARCHAR(50)
);

if OBJECT_ID('bronze.inventory_info','U') is not null
		drop table bronze.inventory_info;
go
CREATE TABLE bronze.inventory_info (
    product_id VARCHAR(50),
    date VARCHAR(50),
    stock_received VARCHAR(50),
    damaged_stock VARCHAR(50)
);
if object_id('bronze.delivery_performance_info','u')is not null
	drop table bronze.delivery_performance_info;
go
CREATE TABLE bronze.delivery_performance_info (
    order_id VARCHAR(50),
    delivery_partner_id VARCHAR(50),
    promised_time VARCHAR(50),
    actual_time VARCHAR(50),
    delivery_time_minutes VARCHAR(50),
    distance_km VARCHAR(50),
    delivery_status VARCHAR(100),
    reasons_if_delayed VARCHAR(300)
);

if object_id('bronze.marketing_performance_info','u')is not null
	drop table bronze.marketing_performance_info;
go
CREATE TABLE bronze.marketing_performance_info (
    campaign_id VARCHAR(50),
    campaign_name VARCHAR(200),
    date VARCHAR(50),
    target_audience VARCHAR(200),
    channel VARCHAR(100),
    impressions VARCHAR(50),
    clicks VARCHAR(50),
    conversions VARCHAR(50),
    spend VARCHAR(50),
    revenue_generated VARCHAR(50),
    roas VARCHAR(50)
);

if object_id('bronze.customer_feedback_info','u')is not null
	drop table bronze.customer_feedback_info;
go
CREATE TABLE bronze.customer_feedback_info (
    feedback_id VARCHAR(50),
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    rating VARCHAR(50),
    feedback_text VARCHAR(500),
    feedback_category VARCHAR(200),
    sentiment VARCHAR(100),
    feedback_date VARCHAR(50)
);

if object_id('bronze.category_icons_info','u')is not null
	drop table bronze.category_icons_info;
go
CREATE TABLE bronze.category_icons_info (
    category VARCHAR(200),
    Img VARCHAR(500)
);


if object_id('bronze.rating_icons_info','u')is not null
	drop table bronze.rating_icons_info;
go
CREATE TABLE bronze.rating_icons_info (
    Rating VARCHAR(50),
    Emoji VARCHAR(500),
    Star VARCHAR(50)
);
