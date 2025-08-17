-- How many sales we have?
SELECT COUNT(*) AS Total_Sales FROM retail_sales;

-- How many customers we have?
SELECT COUNT(DISTINCT(customer_id)) AS Total_Cutomers FROM retail_sales;

SELECT COUNT(DISTINCT(category)) AS Total_Categories FROM retail_sales;

-- Sales of '2022-11-5'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-5';

-- 'Clothing' category, sold more than 10 in Nov-2022
SELECT *
FROM retail_sales
WHERE category = "clothing"
AND quantiy >= 4
AND sale_date BETWEEN "2022-11-1" AND "2022-11-30";

-- Total sales of each category

SELECT category, SUM(total_sale) AS Sold_Amount
FROM retail_sales
GROUP BY category;

-- AVG age of customers who purchased beauty category
SELECT AVG(age) AS Average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Transactions where total_sale > 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Total transactions (transaction_id) by each gender in each category
SELECT Category, gender, COUNT(*) AS Total_transactions
FROM retail_sales
GROUP BY Category, gender
ORDER BY Category;

-- AVG sale of each month with best selling month of each year
SELECT 
	Year, 
    month, 
    Total_sales_per_month 
    FROM
(SELECT 
	EXTRACT(year FROM sale_date) AS Year,
    EXTRACT(month FROM sale_date) AS month,
    AVG(total_sale) AS Total_sales_per_month,
    RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY AVG(total_sale) DESC) AS Rank1
FROM retail_sales
GROUP BY Year, month) AS t1
WHERE Rank1 = 1;

-- Top 5 customers based on highest total sales
SELECT 
	customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 5;

-- Find number of unique customers who purchased items from each categoty
SELECT category, Count(DISTINCT(customer_id)) AS No_of_customers
FROM retail_sales
GROUP BY category;

-- Write a sql query to create each shift and number of orders
WITH hourly_sale AS
(SELECT
	CASE
		WHEN EXTRACT(hour FROM sale_time) <= 12 THEN "Morning"
		WHEN EXTRACT(hour FROM sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
		ELSE "Evening"
	END AS Shift
FROM retail_sales)
SELECT 
	Shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY Shift


-- End of Project

    