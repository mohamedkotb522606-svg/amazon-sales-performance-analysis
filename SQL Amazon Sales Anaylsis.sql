CREATE TABLE amazon_sales (
    Order_ID VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Order_Date DATE,
    Category VARCHAR(50),
    Product_Name VARCHAR(100),
    Base_Price NUMERIC(10, 2),
    Quantity INTEGER,
    Total_Amount NUMERIC(10, 2),
    Payment_Type VARCHAR(50),
    Shipping_Class VARCHAR(50),
    Order_Status VARCHAR(50),
	Country VARCHAR(100),
	City VARCHAR(100),
	Postal_Code VARCHAR(50),
	Customer_Gender VARCHAR(20),
    Discount_Applied VARCHAR(10),
    Is_Prime_Member VARCHAR(30),
    Year INTEGER,
    Month_Name VARCHAR(20),
    Day_Name VARCHAR(20),
    Quarter VARCHAR(10)  
);

SELECT 
    is_prime_member,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    -- Rounding to 2 decimal places for financial reporting format
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM amazon_sales
GROUP BY is_prime_member;



SELECT 
    is_prime_member,
    -- DISTINCT is critical here to count actual unique customers, ignoring their multiple repeat orders
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(order_id) AS total_orders,
    -- CRITICAL: Casting COUNT to NUMERIC prevents "Integer Division" (which drops decimals in PostgreSQL)
    ROUND(COUNT(order_id)::NUMERIC / COUNT(DISTINCT customer_id), 2) AS avg_orders_per_customer
FROM amazon_sales
GROUP BY is_prime_member;



WITH MonthlySales AS (
	SELECT
		year,
		month_name,
		EXTRACT(MONTH FROM order_date) AS month_num, -- Kept for correct chronological sorting (1-12)
		SUM(total_amount) AS monthly_revenue
	FROM amazon_sales
	GROUP BY year, month_name, EXTRACT(MONTH FROM order_date)
)
SELECT 
	year,
	month_name,
	monthly_revenue,
	-- Window Function: Computing running/cumulative total of revenue across months partitioned by year
	SUM(monthly_revenue) OVER (PARTITION BY year ORDER BY month_num) AS cumulative_revenue,
	-- Window Function: Calculating Month-over-Month (MoM) growth rate percentage using LAG()
	ROUND(
		((monthly_revenue - LAG(monthly_revenue) OVER (PARTITION BY year ORDER BY month_num))
		/ LAG(monthly_revenue) OVER (PARTITION BY year ORDER BY month_num)) * 100 , 2
	) || '%' AS growth_rate_percentage
FROM MonthlySales
ORDER BY year, month_num;



-- Investigating revenue drop across categories in 2026 compared to 2025
SELECT
	year,
	category,
	SUM(total_amount) AS category_revenue,
	-- Window Function: Checking the percentage share of each category per year
	ROUND(
		( SUM(total_amount) / SUM(SUM(total_amount)) OVER (PARTITION BY year) ) * 100, 2
	) || '%' AS category_share_percentage
FROM amazon_sales
WHERE year IN (2025, 2026)
GROUP BY year, category
ORDER BY category, year;