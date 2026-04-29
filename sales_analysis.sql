SET GLOBAL local_infile = 1;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8,@c9,@c10,
 @c11,@c12,@c13,@c14,@c15,@c16,@c17,@c18,
 @qty,@discount,@profit)
SET 
  Quantity = NULLIF(@qty, ''),
  Discount = NULLIF(@discount, ''),
  Profit   = NULLIF(@profit, '');
  
-- Total Customers
SELECT
	COUNT(DISTINCT customer_id) AS total_customers
FROM sales;

-- Total Sales
SELECT
	SUM(sales) AS total_sales
FROM sales;

-- Total Profit
SELECT
	SUM(profit) AS total_profit
FROM sales;

-- Items Sold
SELECT 
	SUM(quantity) AS items_sold
FROM sales;

-- Total sales by region 
-- Business Question: Which region generates the highest and lowest sales?
SELECT
	region,
    SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;
-- Insight:
-- The Central region generates the highest total sales, making it the leading
-- contributor to overall revenue. In contrast, the South region records the
-- lowest sales, indicating weaker market performance. This suggests an
-- opportunity to improve sales in the South region through targeted marketing
-- strategies, promotions, and customer engagement initiatives.

-- Total profit by category 
-- BUSINESS QUESTION : Which category generates the most profit?
SELECT 
    Category,
    SUM(Profit) AS total_profit
FROM sales
GROUP BY Category
ORDER BY total_profit DESC;
-- INSIGHT: Office Supplies generates the highest profit, indicating strong profitability 
-- and effective pricing or cost management. Furniture operates at a loss, 
-- suggesting that despite potential sales, high costs and discounts 
-- are negatively impacting profitability. This highlights a need to review pricing strategies, 
-- cost structures, or discount policies to improve margins.


-- Top 10 Best-Selling Products
-- BUSINESS QUESTION: Which products generate the highest total sales?
SELECT 
    `Product Name`,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;
-- INSIGHTS: The top-performing products are primarily high-value office equipment and technology items, 
-- indicating strong demand for business-related products. This suggests that customers are willing to spend 
-- more on essential productivity tools, highlighting an opportunity to focus on premium product offerings 
-- and targeted marketing strategies.

-- Total sales by segment 
-- BUSINESS QUESTION : Which segment generates the most sales? 
SELECT
    IFNULL(Segment, 'Unknown') AS Segment,
    SUM(sales) AS total_sales
FROM sales
GROUP BY Segment;
-- INSIGHTS: The Consumer segment generates the highest total sales, 
-- followed by Corporate and Home Office. A portion of sales is associated 
-- with an unknown segment, indicating missing data that may impact the 
-- accuracy of segment-level analysis.

	
-- Total Sales by Category
-- BUSINESS QUESTION: Which product category generates the highest total sales?
SELECT 
    Category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY Category;
-- INSIGHTS: Technology is the leading revenue-driving category, indicating strong customer demand 
-- and market performance. Furniture follows, while Office Supplies generates the lowest sales. 
-- This suggests an opportunity to boost Office Supplies through targeted promotions or bundling strategies.


-- Average order value
-- BUSINESS QUESTION: What is the average value of each customer order?
SELECT 
    SUM(sales) / COUNT(DISTINCT `Order ID`) AS avg_order_value
FROM sales;
-- INSIGHTS: The average order value indicates how much revenue is generated per transaction. 
-- A higher value suggests customers are purchasing more per order, while a lower value 
-- may highlight opportunities to increase revenue through promotions.

-- Top performing Region    
-- BUSINESS QUESTION : Which region generates the most profit? 
SELECT
	region,
    SUM(Profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC;
-- Insights : The West region generates the most profit,
			-- indicating strong market demand and customer activity in this area. 


-- Monthly Sales (Top Performing Month)
-- BUSINESS QUESTION : Which Month generates the most sales?
SELECT
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
    SUM(sales) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY monthly_sales DESC;
-- INSIGHTS:
-- September records the highest sales, indicating a peak in performance. 
-- This may reflect seasonal demand or effective promotional activity during this period.

-- Monthly Sales Trend
-- BUSINESS QUESTION : How do sales trend across different months?
SELECT
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month_num,
    SUM(sales) AS monthly_sales
FROM sales
GROUP BY month, month_num
ORDER BY month_num;
-- INSIGHTS:
-- Sales fluctuate across months, with a clear peak in September and a low in February. 
-- This pattern suggests seasonality in customer demand, where peak months can be 
-- optimized for revenue growth, while slower periods may require targeted promotions.




	



  
