USE pizza;

-- DATA ANALYSIS

-- Total Revenue
SELECT ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sales

-- Average Order Value
SELECT ROUND((SUM(total_price) / COUNT(DISTINCT order_id)),2) AS avg_order_value
FROM pizza_sales

-- Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales

-- Average Pizzas Per Order
SELECT ROUND((SUM(quantity) / COUNT(DISTINCT order_id)),2) AS avg_pizzas_per_order
FROM pizza_sales

-- Daily trend of orders

SELECT DAYNAME(STR_TO_DATE(order_date,'%d-%m-%Y')) AS order_day,
       COUNT(DISTINCT order_id) AS daily_trend_of_orders
FROM pizza_sales
GROUP BY order_day

-- Hourly trend of orders

SELECT HOUR(order_time) AS order_hours,
       COUNT(DISTINCT order_id) AS hourly_trend_of_orders
FROM pizza_sales
GROUP BY order_hours
ORDER BY order_hours

-- Percentage of sales by Pizza category

SELECT pizza_category,
       ROUND(SUM(total_price),2) AS total_revenue,
       ROUND(SUM(total_price) * 100 / (
           SELECT SUM(total_price)
           FROM pizza_sales
	   ),2) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category

-- Percentage of sales by Pizza size

SELECT pizza_size,
       ROUND(SUM(total_price),2) AS total_revenue,
       ROUND(SUM(total_price) * 100 / (
           SELECT SUM(total_price)
           FROM pizza_sales
           ),2) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

-- Total pizzas sold by pizza category

SELECT pizza_category, 
	   SUM(quantity) as total_quantities_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_quantities_sold DESC

-- Top 5 Best Sellers by Total Pizzas Sold

SELECT pizza_name, 
	   SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5

-- Bottom 5 Best Sellers by Total Pizzas Sold

SELECT pizza_name,
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5