# 🏬 Blinkit Data Warehouse Project (SQL Server)

## 📌 Project Overview

This project implements a **Data Warehouse solution for Blinkit retail data** using **SQL Server** following a **Medallion Architecture**:

**Bronze → Silver → Gold**

The objective is to transform raw CSV data into a **business-ready analytical model (Star / Galaxy Schema)** for reporting and dashboarding.

---

## 🧱 Architecture Used

| Layer  | Purpose                                      | Method                                  |
|-------|-----------------------------------------------|------------------------------------------|
| Bronze | Raw data ingestion from CSV files           | Full Load, Truncate & Insert, Batch Load |
| Silver | Data cleaning, transformation, validation   | ETL using Stored Procedures              |
| Gold   | Analytical model for reporting              | Views (Star Schema)                     |

---

## 📂 Datasets Used

- Customers
- Orders
- Order Items
- Products
- Inventory
- Delivery Performance
- Customer Feedback
- Category Icons (UI lookup)
- Rating Icons (UI lookup)

---

## 🥉 Bronze Layer – Raw Ingestion

- Data loaded from CSV using **BULK INSERT**
- No transformations applied
- Tables created under `bronze` schema
- Approach: **Batch Processing + Full Load**

---

## 🥈 Silver Layer – Data Cleaning & Transformation

ETL performed using a **stored procedure**:

- Data type conversions (VARCHAR → INT / DATE / DATETIME)
- Null handling and standardization
- Date format corrections
- Cleaning invalid characters
- Business rule corrections (delivery delay, negative time, delay reasons)

Tables created under `silver` schema.

---

## 🥇 Gold Layer – Analytical Star / Galaxy Schema

### ✅ Dimension Views

#### `gold.dim_customers`

- `customer_key` (Surrogate Key)
- Customer name, area, segment
- Registration Month-Year

#### `gold.dim_products`

- `product_key` (Surrogate Key)
- Product details, category, brand
- Pricing and stock limits

---

### ✅ Fact Views

#### `gold.fact_orders`

Central analytical fact combining:

- Orders
- Order items
- Customers
- Products
- Delivery status & delay reason
- Feedback rating & sentiment

**Used for:**

- Sales analysis
- Customer behavior
- Delivery performance
- Feedback analysis

---

#### `gold.fact_inventory`

- Inventory tracking per product per date
- Usable stock calculation

**Used for:**

- Stock monitoring
- Damage analysis
- Replenishment planning

---

## 🎨 Reporting Lookup Tables (For BI Tools)

| Table           | Purpose                                  |
|-----------------|-------------------------------------------|
| category_icons  | Display category images in dashboards     |
| rating_icons    | Display star/emoji ratings                |

> These tables are used only in **Power BI / Tableau**, not inside fact views.

---

## 🧠 Data Modeling Concept

This project follows:

- **Fact Constellation (Galaxy Schema)**
- `fact_orders` star schema
- `fact_inventory` star schema
- Shared dimensions: `dim_customers`, `dim_products`

---

## 🛠️ Technologies Used

- SQL Server
- T-SQL (DDL, DML, Views, Stored Procedures)
- BULK INSERT
- Data Warehouse Modeling
- Star & Galaxy Schema
- Ready for Power BI / Tableau

---

## 📊 Business Use Cases Supported

- Sales & revenue analysis
- Customer segmentation
- Product performance
- Delivery delay analysis
- Feedback & sentiment tracking
- Inventory and stock monitoring

---

## 🚀 Outcome

**Raw CSV files → Cleaned Warehouse → Analytical Model → Ready for Dashboards**

This project demonstrates **real-world Data Engineering, ETL, and Data Modeling skills**.
