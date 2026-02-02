/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
use Blinkit_Dwh
CREATE OR ALTER PROCEDURE bronze.load_bronze as
begin
	declare @start_time Datetime , @end_time Datetime, @batch_start datetime, @batch_end datetime;

	begin try
		set @batch_start = GETDATE();
		print '===============================';
		print 'loading bronze layer';
		print '===============================';


		print 'Customers Data';
		set @start_time = GETDATE();
		truncate table bronze.customers_info;

		bulk insert bronze.customers_info
		from 'C:\Data\blinkit_customers.csv'
		with (
				format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow =  2,
				fieldterminator=',',
				tablock);
		set @end_time = GETDATE();
		print 'customers_info loaded in' + cast(datediff(second,@start_time, @end_time) as varchar) + ' sec';


		print 'Orders Data';
		set @start_time = GETDATE();
		truncate table bronze.orders_info;

		bulk insert bronze.orders_info
		from  'C:\Data\blinkit_orders.csv'
		with(
				format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print 'Orders_info loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';



		print 'order items data';
		set @start_time = GetDate();
		truncate table bronze.order_items_info;

		bulk insert bronze.order_items_info
		from 'C:\Data\blinkit_order_items.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print 'Orders_info loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';


		print 'products data';
		set @start_time = GetDate();
		truncate table bronze.products_info;

		bulk insert bronze.products_info
		from 'C:\Data\blinkit_products.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';


		print 'inventory data';
		set @start_time = GetDate();
		truncate table bronze.inventory_info;

		bulk insert bronze.inventory_info
		from 'C:\Data\blinkit_inventoryNew.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';


		print 'delivery performance data';
		set @start_time = GetDate();
		truncate table bronze.delivery_performance_info;

		bulk insert bronze.delivery_performance_info
		from 'C:\Data\blinkit_delivery_performance.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';



		print 'marketing performance data';
		set @start_time = GetDate();
		truncate table bronze.marketing_performance_info;

		bulk insert bronze.marketing_performance_info
		from 'C:\Data\blinkit_marketing_performance.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';


		print 'CUSTOMER FEEDBACK data';
		set @start_time = GetDate();
		truncate table bronze.customer_feedback_info;

		bulk insert bronze.customer_feedback_info
		from 'C:\Data\blinkit_customer_feedback.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';



		print 'category icons data';
		set @start_time = GetDate();
		truncate table bronze.category_icons_info;

		bulk insert bronze.category_icons_info
		from 'C:\Data\blinkit_Category_Icons.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';


		print 'rating icons data';
		set @start_time = GetDate();
		truncate table bronze.rating_icons_info;

		bulk insert bronze.rating_icons_info
		from 'C:\Data\blinkit_Rating_Icon.csv'
		with(format = 'CSV',
				rowterminator = '0x0a',
                fieldquote = '"',
				firstrow=2,
				fieldterminator=',',
				tablock);
		set @end_time = getDate();
		print ' loaded in' + cast(datediff(second,@start_time,@end_time) as varchar) + 'secs';

	end try

	Begin catch
			print 'Error in Bronze';
			print error_message();
	end catch
end;


select * from bronze.customers_info;






