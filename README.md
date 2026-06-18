# 📊 Amazon Sales Performance & Data Diagnostics Analytics Project

An end-to-end data analytics and business intelligence solution tracking Amazon transactional logs across **2024, 2025, and 2026**. This project focuses on identifying systemic revenue anomalies, uncovering operational bottlenecks, evaluating customer retention, and mapping product distribution dynamics.

---

## 📌 1. Project Architecture & Ecosystem
This project simulates the complete workflow of an Enterprise Data Analyst, split into distinct modular stages:
* **Data Tier:** Structured processing of multi-year transactional logs (Sales, Customers, Products, and Order Status).
* **UI/UX Design Tier:** Bespoke, high-contrast, dark-themed canvas engineering designed in **Canva** to streamline visual ingestion and minimize user cognitive fatigue.
* **BI & Engineering Tier:** Dynamic star-schema modeling and advanced Business Intelligence metrics developed using **Power BI Desktop** and **DAX (Data Analysis Expressions)**.

---

## 🛠️ 2. Technical Execution Lifecycle

### A. Data Cleansing & ETL (Extract, Transform, Load)
Before importing data into the data model, a rigorous data cleaning pipeline was applied to guarantee absolute data integrity:
1.  **Anomalies & Duplicate Filtering:** Scanned the transactional matrix to remove structural redundancies, duplicate `Order_ID` strings, and null customer attributes.
2.  **Date Dimensionalization:** Deconstructed the raw chronological timestamps into granular temporal metrics:
    * `Year` (Extracted integer for macro-level seasonal filtering).
    * `Month_Name` (Mapped chronologically from January to December).
    * `Month_Num` (Assigned numerical sorting IDs to force correct chronological visualization instead of default alphabetical ordering).
3.  **Data Type Synchronization:** Explicitly mapped transactional metrics: Currency values (`Total_Amount`, `Base_Price`) were standardized into financial decimals, and product metrics (`Quantity`) into integers.

### B. Advanced KPI Engineering (DAX Matrix)
To power the business matrix cards without lagging performance, custom DAX metrics were programmed:
* **Total Revenue Accumulator:**
    ```DAX
    Total Revenue = SUM(amazon_clean_data[Total_Amount])
    ```
    *Formats dynamically into localized billions/millions ($1.265bn).*
* **Distinct Order Counter:**
    ```DAX
    Total Orders = COUNT(amazon_clean_data[Order_ID])
    ```
    *Provides real-time transactional counts across active segments.*
* **Average Order Value (AOV):**
    ```DAX
    Average Order Value = AVERAGE(amazon_clean_data[Total_Amount])
    ```
    *Tracks financial purchasing health per transactional basket ($1.275K).*
* **Advanced Customer Velocity (Avg Orders per Customer):**
    ```DAX
    Avg_Orders_Per_Cust = COUNT(amazon_clean_data[Order_ID]) / DISTINCTCOUNT(amazon_clean_data[Customer_ID])
    ```
    *Calculates structural customer loyalty by dividing total transactions by unique, distinct user IDs. The system calculated an exceptional metric of **99.20 orders per customer**.*

### C. Visual Dashboard Layout & Interaction
* **Line Chart (Temporal Trend):** Displays monthly performance over three years. Plots a clear visual contrast showing the 2026 financial cliff.
* **Donut Chart (Categorical Diagnostics):** Evaluates structural volume dispersion across main categories (Clothing, Electronics, Books, Beauty, Home & Kitchen).
* **Scatter Plot (Pricing Elasticity):** Maps out the correlation vectors between product `Base_Price` and transaction `Quantity` to detect volume drivers.
* **Clustered Column Chart (User Segmentation):** Contrasts overall spending power and financial volume of **Regular Customers** versus **Prime Members**.
* **Interactive Slicers:** Integrated dynamic native slicers mapped directly to chronological variables (`Year`), allowing interactive database queries instantly.

---

## 🔍 3. Executive Summary: The 2026 Diagnostic Discovery
Upon visualizing the final compiled data model, a critical business anomaly was successfully discovered:
1.  **The 2026 Sales Collapse:** While fiscal years 2024 and 2025 demonstrated stable, repeating monthly trends consistently exceeding **$40M per month**, fiscal year 2026 witnessed a catastrophic revenue drop starting in **March 2026** and plunging to near-zero by **April 2026**, remaining flat for the rest of the year.
2.  **The Category Paradox:** Interestingly, the **Donut Chart** proves that the percentage market share of individual categories (e.g., Electronics vs. Clothing) remained completely unchanged during the crash. This implies that the revenue collapse was **not** caused by a sudden consumer dislike of a specific product type.
3.  **The Operational Diagnosis:** Because the customer retention KPI remains incredibly high (**99.20**), and category distribution is perfectly stable, the crash indicates a systemic platform-wide operational issue rather than an organic loss of consumer demand.

---

## 💡 4. Strategic Business Recommendations & Action Plan
Based on the data diagnostic metrics, the following executive actions are recommended for Amazon's management team:

### 🚨 Short-Term Interventions (Immediate Operational Fixes)
1.  **Investigate API & Data-Logging Infrastructure:** Since category shares are perfectly flat and sales hit an exact baseline near zero, there is a high probability of a **systemic data-logging failure or API disconnection** occurring between the Amazon storefront and the internal reporting server starting March/April 2026. Audit the ETL data pipeline immediately.
2.  **Audit regional Payment Gateways:** Verify whether a localized payment gateway or regional compliance law blocked transactional clearances during Q1/Q2 of 2026.

### 📈 Mid-Term Growth Operations (Value Extraction)
3.  **Monetize High-Retention Customers:** Since unique customers average an astounding **99.20 orders**, Amazon possesses an ultra-loyal consumer core. Launch hyper-targeted micro-incentive loyalty programs to maximize their Lifetime Value (LTV).
4.  **Targeted Prime Migration Campaigns:** Reviewing the **Prime vs. Regular** column chart, Regular Customers still generate a massive volume of revenue. Launch targeted marketing offering promotional 3-month Prime trials to Regular Customers to convert them into higher-margin subscription loops.
5.  **Dynamic Pricing Correction via Scatter Insights:** Use the Scatter Plot data to optimize pricing thresholds. Identify the optimal price ceilings where transaction quantities do not drop, allowing algorithmic dynamic pricing models to automatically protect profit margins.


