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

---

## 📦 Scope

- Focused on **current data only**
- Does **not** include historical or slowly changing dimensions

---

## 🗂️ Deliverables

- ✅ Star Schema: 1 Fact Table, 3 Dimension Tables
- ✅ Stored Procedures for Gold Layer view creation
- ✅ Gold Layer Data Catalog (`.Rmd` and `.md`)
- ✅ Source-to-Target Mappings
- ✅ README Documentation

---

## 📁 Layers Implemented

- **Silver Layer**  
  Cleaned and normalized tables: `orders`, `order_details`, `products`, `customers`, `inventory`

- **Gold Layer**  
  Denormalized star schema views:
  - `gold.fact_order_details`
  - `gold.dim_customers`
  - `gold.dim_products`
  - `gold.dim_orders_
