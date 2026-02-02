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
GO

CREATE OR ALTER PROCEDURE  bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();

		PRINT '>>>>>><<<<<<<<<<<<<<';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '>>>>>><<<<<<<<<<<<<<';


		SET @start_time = GETDATE();
		PRINT 'Customers Info';
		TRUNCATE TABLE bronze.customers_info;
		BULK INSERT bronze.customers_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_customers.csv'
		WITH(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Customers info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Orders Info';
		TRUNCATE TABLE bronze.orders_info;
		BULK INSERT bronze.orders_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_orders.csv'
		WITH (		FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Order into loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Order items Info';
		TRUNCATE TABLE bronze.order_items_info;
		BULK INSERT bronze.order_items_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_order_items.csv'
		WITH(
					FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Order Items info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Products Info';
		TRUNCATE TABLE bronze.products_info;
		BULK INSERT bronze.products_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_products.csv'
		WITH (			
					FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Products Info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Inventory Info';
		TRUNCATE TABLE bronze.inventory_info;
		BULK INSERT bronze.inventory_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_inventoryNew.csv'
		WITH (		FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Inventory info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Delivery performance Info'; 
		TRUNCATE TABLE bronze.delivery_performance_info;
		BULK INSERT bronze.delivery_performance_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_delivery_performance.csv'
		WITH(	
					FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Delivery performance info loaded in:' +  CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Marketing Performance Info';
		TRUNCATE TABLE bronze.marketing_performance_info;
		BULK INSERT bronze.marketing_performance_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_marketing_performance.csv'
		WITH(		FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Marketing performance loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Customer Feedback Info';
		TRUNCATE TABLE bronze.customer_feedback_info;
		BULK INSERT bronze.customer_feedback_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\blinkit_customer_feedback.csv'
		WITH(       FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'customer-feedback info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Category Icons info';
		TRUNCATE TABLE bronze.category_icons_info;
		BULK INSERT bronze.category_icons_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\Category_Icons.csv'
		WITH (		FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Category icons info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @start_time = GETDATE();
		PRINT 'Rating Icons Info';
		TRUNCATE TABLE bronze.rating_icons_info;
		BULK INSERT bronze.rating_icons_info
		FROM 'C:\Users\Mounika Reddy\Downloads\archive (5) 2\Rating_Icon.csv' 
		WITH(       FIRSTROW=2,
					FIELDTERMINATOR = ',',
					FIELDQUOTE = '"',  
					CODEPAGE = '65001',
					TABLOCK);
		SET @end_time = GETDATE();
		PRINT 'Rating icons Info loaded in:'+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR) + 'secs';

		SET @batch_end_time = GETDATE();
		PRINT 'Loading Bronze layer is Completed';
		PRINT 'Total Duration is:' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS VARCHAR) +'secs';
	END TRY
	BEGIN CATCH
	PRINT 'ERROR Occured during loading Bronze layer';
	PRINT 'Error message' + CAST(ERROR_NUMBER() AS VARCHAR);
	PRINT 'Error message' + CAST(ERROR_STATE() AS VARCHAR);
	END CATCH
END




