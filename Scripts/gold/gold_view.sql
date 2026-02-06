/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


-- Creating Views
IF OBJECT_ID('gold.dim_customers','V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY c.customer_id) AS customer_key,
    c.customer_id,
    c.customer_name,
    c.area,
    c.customer_segment,
	FORMAT(registration_date,'MMM-yyyy') AS registration_date
FROM silver.customers_info c
GO

IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,

    product_id,
    product_name,
    category,
    brand,
    price,
    mrp,
    margin_percentage,
    shelf_life_days,
    min_stock_level,
    max_stock_level

FROM silver.products_info;
GO


IF OBJECT_ID('gold.fact_orders' ,'V') IS NOT NULL
		DROP VIEW gold.fact_orders;
GO
CREATE VIEW gold.fact_orders AS
SELECT
	ROW_NUMBER() OVER(ORDER BY o.order_id) AS order_key,
	c.customer_id,
    c.customer_name,
    c.area,
    c.customer_segment,

	o.order_id,
	o.order_date,


	oi.product_id,
	p.product_name,
	p.category,
	p.brand,

	oi.quantity,
	oi.unit_price,
	(oi.quantity * oi.unit_price) AS total_cost,

	o.payment_method,

	dp.delivery_status,
	ISNULL(dp.reasons_if_delayed,'On Time') AS delay_reason,

	fb.rating,
	fb.feedback_category,
	fb.sentiment

FROM silver.orders_info o

LEFT JOIN gold.dim_customers c
ON c.customer_id = o.customer_id

LEFT JOIN silver.order_items_info oi
ON o.order_id = oi.order_id

LEFT JOIN gold.dim_products p
ON oi.product_id = p.product_id

LEFT JOIN silver.delivery_performance_info dp
    ON o.order_id = dp.order_id

LEFT JOIN silver.customer_feedback_info fb
    ON o.order_id = fb.order_id;


GO

IF OBJECT_ID('gold.fact_inventory','V') IS NOT NULL
		DROP VIEW gold.fact_inventory;
GO
CREATE VIEW gold.fact_inventory AS
SELECT
	ROW_NUMBER() OVER(ORDER BY i.product_id)  AS inventory_key,
	i.product_id,
	p.product_name,
	p.category,
	p.brand,

	i.inventory_date,
	i.stock_received,
	i.damaged_stock,
	(i.stock_received - i.damaged_stock) AS usable_stock

FROM silver.inventory_info i
LEFT JOIN gold.dim_products p
ON i.product_id = p.product_id
GO

IF OBJECT_ID('gold.fact_marketing_performance','V') IS NOT NULL
    DROP VIEW gold.fact_marketing_performance;
GO

CREATE VIEW gold.fact_marketing_performance AS
SELECT
    ROW_NUMBER() OVER (ORDER BY m.campaign_date) AS marketing_key,

    m.campaign_date,
    m.campaign_name,
    m.channel,

    m.impressions,
    m.clicks,
    m.spend,
    m.conversions,

    -- Orders happened on same day
    COUNT(DISTINCT o.order_id)        AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_sales_amount,

    -- KPI calculations
    CASE 
        WHEN m.clicks = 0 THEN 0 
        ELSE CAST(m.conversions AS FLOAT) / m.clicks 
    END AS conversion_rate,

    CASE 
        WHEN COUNT(DISTINCT o.order_id) = 0 THEN 0
        ELSE m.spend / COUNT(DISTINCT o.order_id)
    END AS cost_per_order

FROM silver.marketing_performance_info m

LEFT JOIN silver.orders_info o
    ON CAST(o.order_date AS DATE) = m.campaign_date

LEFT JOIN silver.order_items_info oi
    ON o.order_id = oi.order_id

GROUP BY
    m.campaign_date,
    m.campaign_name,
    m.channel,
    m.impressions,
    m.clicks,
    m.spend,
    m.conversions;
GO

select top 5* from gold.dim_customers;
select top 5* from gold.dim_products;
select top 5* from gold.fact_orders;
select top 5* from gold.fact_inventory;
select top 5* from gold.fact_marketing_performance
