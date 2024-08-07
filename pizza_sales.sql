--create a database to store data
create database pizza_sales_db;

--create a table to store data properly
create table pizza_sales(
	"pizza_id" int primary key ,
	"order_id" int ,
	"pizza_name_id"  TEXT ,
	"quantity" int ,
	"order_date" date ,
	"order_time" time ,
	"unit_price" float ,
	"total_price" float ,
	"pizza_size"  TEXT,
	"pizza_category" TEXT ,
	"pizza_ingredients" TEXT ,
	"pizza_name" TEXT);

--Now we have to import our data from csv file to this table 

copy pizza_sales(pizza_id ,order_id ,pizza_name_id ,quantity,order_date,order_time, unit_price , total_price ,pizza_size, pizza_category,pizza_ingredients,pizza_name)
from 'D:\Data Analyst\Project\pizza_sales.csv'
delimiter ','
csv header;

--to view data from table

select * from pizza_sales;

--total revenue

select sum(total_price) as Total_revenue from pizza_sales;

--average order value

select (sum(total_price)/count(distinct order_id)) as Average_order_value from pizza_sales;

--Total pizzas sold

select sum(quantity) as Total_pizza_sold from pizza_sales

--Total Orders

select count(distinct order_id) as Total_orders from pizza_sales;

--Average pizzas per order

select cast(cast(sum(quantity) as decimal (10,2))/cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2))from pizza_sales

--Daily trend for total orders

select extract(dow from order_date) as order_day , count(distinct order_id) as Total_orders
from pizza_sales
group by extract(dow from order_date)

--You can also get the output from below code 
SELECT TO_CHAR(order_date, 'Day') AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')

--Monthly trend for total orders

select extract(month from order_date) as month_name , count(distinct order_id)
from pizza_sales 
group by extract(month from order_date)
	order by count(distinct order_id) desc

--alternative query to get the monthly order details

SELECT TO_CHAR(order_date, 'Month') AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Month')

--percentage sales by pizza category

select pizza_category , sum(total_price) as total_sales , (sum(total_price)* 100 )/(select sum(total_price) from pizza_sales) as sales_percentage
from pizza_sales
group by pizza_category 
order by sales_percentage desc

--percentage sales by pizza category according to the month

select pizza_category , sum(total_price) as total_sales , (sum(total_price)* 100 )/(select sum(total_price) from pizza_sales where extract(month from order_date)=1) as sales_percentage
from pizza_sales
where extract(month from order_date) = 1
group by pizza_category 

--percentage sales by pizza size
select pizza_size , sum(total_price) as total_sales , (sum(total_price)* 100 )/(select sum(total_price) from pizza_sales) as sales_percentage
from pizza_sales
group by pizza_size 

--percentage sales by pizza size and month
	
select pizza_size , sum(total_price) as total_sales , (sum(total_price)* 100 )/(select sum(total_price) from pizza_sales where extract(month from order_date)=1) as sales_percentage
from pizza_sales
where extract(month from order_date) = 1
group by pizza_size

--Top 5 Best sellers by revenue - Total quantity and Total Orders

select pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc limit 5

--Bottom 5 Worst sellers by revenue - Total quantity and Total Orders

select pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue limit 5

--for quantity 
	--Top 5
	
select pizza_name , sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc limit 5

	--bottom 5

select pizza_name , sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity limit 5

--for orders
	--top 5

select pizza_name , count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc limit 5

	--bottom 5

select pizza_name , count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders limit 5