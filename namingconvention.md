## 🧾 Naming Conventions

Establishing a consistent naming convention ensures clarity, maintainability, and scalability across all layers of the data warehouse.

---

### ✅ General Rules

- Use **`snake_case`** for all names (lowercase + underscores)
- Use **English** for all object and column names
- **Avoid SQL reserved keywords** as names

---

### 🟫 Bronze Layer

- **Purpose:** Mirror raw source data (as-is)
- **Format:** `<source>_<table_name>`
- **Example:**  
  - `retail_orders`  
  - `retail_products`

---

### 🪙 Silver Layer

- **Purpose:** Cleaned and standardized data
- **Format:** `<source>_<table_name>`
- **Example:**  
  - `retail_order_details`  
  - `retail_customers`

---

### ⭐ Gold Layer

- **Purpose:** Star schema views, reporting tables
- **Format:** `<category>_<entity>`
  - `dim_` = Dimension table  
  - `fact_` = Fact table  
  - `report_` = Reporting/Aggregated views

- **Examples:**
  - `dim_customers`
  - `dim_products`
  - `fact_order_details`
  - `report_sales_summary`

---

### 🧱 Column Naming

- **Surrogate Keys:** `<table>_key`  
  _Example:_ `customer_key`, `product_key`

- **Technical Metadata Columns:** `dwh_<purpose>`  
  _Example:_ `dwh_load_date`, `dwh_update_flag`

---

### ⚙️ Stored Procedures

- **Format:** `load_<layer>`  
  _Examples:_
  - `load_bronze`
  - `load_silver`
  - `load_gold`

---

Consistent naming helps developers, analysts, and stakeholders understand and navigate the data model quickly and accurately.
