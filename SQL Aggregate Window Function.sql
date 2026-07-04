-- SQL Aggregate Window Functions

-- Find the total number of orders 

select 
count(*) total_orders
from sales.orders;

-- Find the total number of orders 
-- Additionally provide details such order id and orderdate

select 
orderid,
orderdate,
count(*) over() as total_orders
from sales.orders;

-- FInd the total orders for each customers with other details

select 
orderid,
customerid,
count(*) over(partition by customerid) as order_customers
from sales.orders;


-- Find the total number of customers,
-- additionally provide all customer's details

select 
*,
count(*) over() as total_customers
from sales.customers;

-- Find the total number of scores for the customers

select
*,
count(score) over() as total_score
from sales.customers;


-- Check whether the table 'Ordersarchive' contains any duplicate rows
select 
*
from(
select 
orderid,
count(*) over(Partition by orderid) as check_Pk
from sales.ordersarchive
)t where check_pk>1 ;

-- Find the total sales across all orders
-- and total sales for each product
-- additionally provide detals such as orderid and orderdate

select 
	orderid,
	orderdate,
	sales,
	sum(sales) over() total_sales,
	sum(sales) over(partition by productid) as sales_product
from sales.orders;


-- Find the percentage contribution of each products sales to total sales

select 
orderid,
productid,
sales,
sum(sales) over() total_sales,
round(cast(sales as numeric)/sum(sales) over() *100,2)as percent_product
from sales.orders;

-- Find the average sales across all orders 
-- And fing the average sales for each product 
-- Additionally provide details such as orderid, orderdate

select 
orderid,
orderdate,
round(avg(coalesce(sales,0)) over(),2) average_sales,
round(avg(coalesce(sales,0)) over(partition by productid),2) as avg_product_sales
from sales.orders;


-- FInd the average score of customers 
-- with avg score for each customers
-- Additionally provide details such as customerid, and lastname

select 
customerid,
lastname,
round(avg(coalesce(score,0)) over(),2) average_score,
round(avg(coalesce(score,0)) over(partition by customerid),2) as avg_customer_score
from sales.customers;

-- Find all orders where sales are higher than the average sales across all orders

select 
*
from(
select
orderid,
productid,
avg(coalesce(sales,0)) over() as average_sales,
sales
from sales.orders
)t where sales>average_sales;


-- Find the highest and lowest of all orders 
-- Find the highest and lowest sales for each product 
-- Additionally provide details such as orderid,orderdate

select 
orderid,
orderdate,
productid,
max(sales) over() as highest_sales,
min(sales) over() as lowest_sales,
max(sales) over(partition by productid) as highest_sales_product,
min(sales) over(partition by productid) as lowest_sales_product
from sales.orders;


-- Show the employees who have the highest salaries 

select 
*
from(
select 
*,
max(salary) over() as highest_salary
from sales.employees
)t where salary=highest_salary;


-- Calculate the deviation of each sale from both the minimum and maximum sales amounts.

select 
orderid,
orderdate,
productid,
sales,
max(sales) over() as highest_sales,
min(sales) over() as lowest_sales,
max(sales) over()-sales as deviation_max,
sales-min(sales) over() as deviation_min
from sales.orders;

-- calculate the moving average of sales for each product over time


select 
orderid,
productid,
orderdate,
sales,
avg(sales) over(partition by productid) avg_product,
avg(sales) over(partition by productid order by orderdate) moving_avg_product
from sales.orders;

--calculate the moving average of sales for each product over time, including only the next order

select 
orderid,
productid,
orderdate,
sales,
avg(sales) over(partition by productid) avg_product,
avg(sales) over(partition by productid order by orderdate rows between current row and 1 following) rolling_avg_product
from sales.orders;

