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
customer_id int,
customer_name NVARCHAR(500),
email NVARCHAR(500),
phone NVARCHAR(500),
address NVARCHAR(500),
area NVARCHAR(500),
pincode NVARCHAR(500),
registration_date NVARCHAR(500),
customer_segment NVARCHAR(500),
total_orders NVARCHAR(500),
avg_order_value NVARCHAR(500)
);


if OBJECT_ID('bronze.orders_info','U') is not null
		drop table bronze.orders_info;
go
CREATE TABLE bronze.orders_info (
    order_id NVARCHAR(500),
    customer_id NVARCHAR(500),
    order_date NVARCHAR(500),
    promised_delivery_time NVARCHAR(500),
    actual_delivery_time NVARCHAR(500),
    delivery_status NVARCHAR(500),
    order_total NVARCHAR(500),
    payment_method NVARCHAR(500),
    delivery_partner_id NVARCHAR(500),
    store_id NVARCHAR(500)
);


if OBJECT_ID('bronze.order_items_info','U') is not null
		drop table bronze.order_items_info;
go
CREATE TABLE bronze.order_items_info (
    order_id NVARCHAR(500),
    product_id NVARCHAR(500),
    quantity NVARCHAR(500),
    unit_price NVARCHAR(500)
);

if OBJECT_ID('bronze.products_info','U') is not null
		drop table bronze.products_info;
go
CREATE TABLE bronze.products_info (
    product_id NVARCHAR(500),
    product_name NVARCHAR(500),
    category NVARCHAR(500),
    brand NVARCHAR(500),
    price NVARCHAR(500),
    mrp NVARCHAR(500),
    margin_percentage NVARCHAR(500),
    shelf_life_days NVARCHAR(500),
    min_stock_level NVARCHAR(500),
    max_stock_level NVARCHAR(500)
);

if OBJECT_ID('bronze.inventory_info','U') is not null
		drop table bronze.inventory_info;
go
CREATE TABLE bronze.inventory_info (
    product_id NVARCHAR(500),
    date NVARCHAR(500),
    stock_received NVARCHAR(500),
    damaged_stock NVARCHAR(500)
);
if object_id('bronze.delivery_performance_info','u')is not null
	drop table bronze.delivery_performance_info;
go
CREATE TABLE bronze.delivery_performance_info (
    order_id NVARCHAR(500),
    delivery_partner_id NVARCHAR(500),
    promised_time NVARCHAR(500),
    actual_time NVARCHAR(500),
    delivery_time_minutes NVARCHAR(500),
    distance_km NVARCHAR(500),
    delivery_status NVARCHAR(500),
    reasons_if_delayed NVARCHAR(500)
);

if object_id('bronze.marketing_performance_info','u')is not null
	drop table bronze.marketing_performance_info;
go
CREATE TABLE bronze.marketing_performance_info (
    campaign_id NVARCHAR(500),
    campaign_name NVARCHAR(500),
    date NVARCHAR(500),
    target_audience NVARCHAR(500),
    channel NVARCHAR(500),
    impressions NVARCHAR(500),
    clicks NVARCHAR(500),
    conversions NVARCHAR(500),
    spend NVARCHAR(500),
    revenue_generated NVARCHAR(500),
    roas NVARCHAR(500)
);

if object_id('bronze.customer_feedback_info','u')is not null
	drop table bronze.customer_feedback_info;
go
CREATE TABLE bronze.customer_feedback_info (
    feedback_id NVARCHAR(500),
    order_id NVARCHAR(500),
    customer_id NVARCHAR(500),
    rating NVARCHAR(500),
    feedback_text NVARCHAR(500),
    feedback_category NVARCHAR(500),
    sentiment NVARCHAR(500),
    feedback_date NVARCHAR(500)
);

if object_id('bronze.category_icons_info','u')is not null
	drop table bronze.category_icons_info;
go
CREATE TABLE bronze.category_icons_info (
    category NVARCHAR(500),
    Image_link NVARCHAR(500)
);


if object_id('bronze.rating_icons_info','u')is not null
	drop table bronze.rating_icons_info;
go
CREATE TABLE bronze.rating_icons_info (
    Rating NVARCHAR(500),
    Emoji NVARCHAR(500),
    Star NVARCHAR(500)
)
