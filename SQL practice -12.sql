-- SQL PRACTICE 

/*
1. Using sales.orders write 
-orderid 
-customerid
-sales
-difference between current sales and previous sales 

*/

select 
	orderid,
	customerid,
	sales,
	round(
		sales-lag(sales) over(
		partition by customerid 
		order by orderid asc)
	,2) as diff
from sales.orders;

/*
2. Using sales.orders, write a query that shows 
- orderid, 
- customerid, 
- sales,
- Total sales per customer

*/

select 
orderid, 
customerid,
sales,
sum(sales) over(partition by customerid) as total_sales
from sales.orders;

/* 
3.  Using sales.orders, write a query to show:

orderid
customerid
sales
average sales per customer

*/

select 
orderid, 
customerid,
sales,
round(avg(sales) over(partition by customerid ),2) as average_sales
from sales.orders;


/* 
4. Using sales.orders, write a query to show:

orderid
customerid
sales
maximum sales per customer

*/

select 
orderid, 
customerid,
sales,
max(sales) over(partition by customerid) as max_sales
from sales.orders;

/* 
5. Using sales.orders, write a query to show:

orderid
customerid
sales
number of orders per customer 
*/

select 
orderid,
customerid,
sales,
count(orderid) over(partition by customerid) as total_orders
from sales.orders;


/* 
6. Using sales.orders, write a query to show:

orderid
customerid
sales
difference between each order’s sales and that customer’s average sales
*/

select 
orderid,
customerid,
sales,
round(sales-avg(sales) over(partition by customerid),2) as diff
from sales.orders;

/* 
7. Using sales.orders, write a query to show:
orderid
customerid
sales
running total of sales per customer ordered by orderid
*/

select 
orderid,
customerid,
sales,
sum(sales) over(partition by customerid order by orderid rows between unbounded preceding and current row) as running_total
from sales.orders;

/*
8. Using sales.orders, write a query to show:

orderid
customerid
sales
highest sales per customer
*/

select 
orderid,
customerid,
sales,
max(sales) over(partition by customerid) as highest_sales_customer
from sales.orders;

/*
9. Using sales.orders, write a query to show:

orderid
customerid
sales
rank of each order within each customer based on sales
*/

select 
orderid,
customerid,
sales,
rank() over(partition by customerid order by sales desc) as rank_customers
from sales.orders;

/* 10. Using sales.orders, write a query to show:

orderid
customerid
sales
row number of each order within each customer based on sales descending
Requirement:
Use ROW_NUMBER()
*/

select 
orderid,
customerid,
sales,
row_number() over(partition by customerid order by sales desc) as rank_customers
from sales.orders;