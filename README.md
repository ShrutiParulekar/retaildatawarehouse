# 🏬 Retail Data Warehouse Project

## 📌 Project Objective

Design and implement a **retail-focused data warehouse** that consolidates customer, order, product, and inventory data to enable efficient, scalable, and insightful business reporting and analytics using **SQL Server**.

---

## 🎯 Goals

- **Centralize Data**  
  Integrate data from multiple sources (orders, products, customers, inventory) into a unified model.

- **Ensure Data Quality**  
  Clean, structured, and relational data modeled using a **Star Schema** design.

- **Enable BI Reporting**  
  Power interactive dashboards in **Power BI**, **Tableau**, or **Looker** to analyze:
  - Sales performance  
  - Customer behavior  
  - Product popularity  
  - Business decision-making

- **Implement ETL Processes**  
  Simulate or script **ETL pipelines** using **SQL Stored Procedures** scheduled at specific intervals.

- **Documentation**  
  Provide clear and structured documentation for stakeholders and the analytics team.

  
<img width="813" alt="Screenshot 2025-03-23 at 10 34 55 PM" src="https://github.com/user-attachments/assets/c364939d-0e3c-4344-b6c9-63521aaa5a74" />



---

## 📦 Scope

- Focused on **current data only**
- Does **not** include historical or slowly changing dimensions

---

## 🧠 Why Medallion Architecture?

I followed the **Medallion Architecture (Bronze → Silver → Gold)** to bring structure, reliability, and reusability to the data pipeline:

- **Bronze Layer**: Raw ingestion of CSV files as-is
- **Silver Layer**: Cleaned, joined, and structured relational tables
- **Gold Layer**: Dimensional model (Star Schema) for analytics

This approach ensures:
- 🔄 **Traceable lineage**
- 🧹 **Incremental cleaning & transformation**
- 📊 **BI-ready structured outputs**

---
<img width="849" alt="Screenshot 2025-03-23 at 10 31 06 PM" src="https://github.com/user-attachments/assets/794ac16b-cfb3-499e-91ed-de087db9339b" />

## 📁 Layers Implemented

**Bronze Layer (Raw Zone)**

- Loaded the CSVs into raw SQL tables without transformation.
- Maintained 1:1 mapping with source format.
- Examples: `orders`, `customers`, `order_details`, `inventory`, `products`

---

**Silver Layer (Cleansed Zone)**

- Cleaned and standardized data:
  - Removed nulls
  - Fixed datatypes
  - Created relationships via joins
- Retained business logic and normalized structure.

---

 **Gold Layer (Business Layer)**

- Built a **Star Schema** for reporting:
  - 1 **Fact Table**: `fact_order_details`
  - 3 **Dimension Tables**: `dim_customers`, `dim_orders`, `dim_products`

- Created **stored procedures** to automate creation of Gold Layer views.
 
<img width="817" alt="Screenshot 2025-03-23 at 10 32 40 PM" src="https://github.com/user-attachments/assets/0c73c227-6393-4318-a632-3393aa65e19c" />

## 🌟 Impact of This Project

- ✅ **BI-Ready Dataset**: Easily consumed by tools like Power BI, Tableau
- ✅ **Maintainable Pipeline**: Layered transformation via SQL procedures
- ✅ **Clean Schema**: Easy for analysts to query and explore
- ✅ **Reusable Framework**: Supports future enhancements like historical tracking or real-time ingestion

