/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
if exists (select 1 from sys.databases where name='Blinkit_Dwh')
begin
     Alter database Blinkit_Dwh set single_user with rollback immediate;
	 drop database Blinkit_Dwh
end;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE Blinkit_Dwh;
GO

USE Blinkit_Dwh;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
