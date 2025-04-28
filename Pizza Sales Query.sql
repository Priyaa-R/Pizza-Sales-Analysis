select * from pizza_sales

-- Total Revenue
select SUM(total_price) as Total_Revenue from pizza_sales

--Average Order Value
select SUM(total_price) / COUNT(distinct order_id) as Avg_Order_Val from pizza_sales

--Total Pizza Sold
select SUM(quantity) as Total_Pizza_Sold from pizza_sales

--Total Order
select COUNT(distinct order_id) as Total_Order from pizza_sales

--Average Pizzas per order
select cast(cast(SUM(quantity) as decimal(10,2)) / 
cast(COUNT(distinct order_id) as decimal(10,2)) 
as decimal(10,2)) 
as Avg_Per_Pizza from pizza_sales

--Daily Trend

select DATENAME(DW,order_date) as order_day, COUNT(distinct order_id) as total_order from pizza_sales
group by DATENAME(DW, order_date)

--Hourly Trend

select DATEPART(hour, order_time) as order_hours , COUNT(distinct order_id) as total_orders from pizza_sales
group by DATEPART(hour, order_time)
order by COUNT(distinct order_id)

-- % of sales by pizza category

select pizza_category, sum(total_price) as total_price, cast(SUM(total_price) *100/ (select SUM(total_price) from pizza_sales where month(order_date) = 1) as decimal(10,2)) 
as Percent_Sales from pizza_sales 
where month(order_date) = 1
group by pizza_category

-- percentage of sales by pizza size

select pizza_size, sum(total_price) as total_price, round (SUM(total_price) *100/ (select SUM(total_price) from pizza_sales where datepart(quarter, order_date) = 1),2) 
as Percent_Sales from pizza_sales 
where datepart(quarter,order_date) = 1
group by pizza_size
order by pizza_size

--total pizzas sold by pizza category

select pizza_category, SUM(quantity) as Total_Pizzas from pizza_sales
group by Pizza_category

--top 5 best sold pizzas

select top 5 pizza_name, SUM(quantity) as Top_5 from pizza_sales
where MONTH(order_date)=2
group by pizza_name
order by SUM(quantity) desc

--bottom 5 sold pizzas

select top 5 pizza_name, SUM(quantity) as Top_5 from pizza_sales
where month(order_date)= 1
group by pizza_name
order by SUM(quantity) asc



