-- SQL practice 

/* 1. Using the sales.orders table , display: 
- orderid
- sales
- total sales of all orders beside every row 
do no use group by */

select 
orderid,
sales,
sum(sales) over() as total_sales
from sales.orders;

/* 
2. Using the sales.orders table, display:

orderid
sales
the average sales beside every row

Do not use GROUP BY.
*/

select 
orderid,
sales,
round(avg(sales) over(),2) as average_sales
from sales.orders;

/* 
3. Using the sales.orders table, display:

orderid
sales
the highest sales value beside every row

Do not use GROUP BY.
*/

select 
orderid,
sales,
max(sales) over() as max_sales
from sales.orders;

/*
4. Using the sales.orders table, display:

orderid
sales
the number of orders beside every row

Do not use GROUP BY.
*/

select 
orderid,
sales,
count(orderid) over() as total_orders
from sales.orders;


/*
5. Using the sales.orders table, display:

orderid
sales
the difference between each order's sales and the company's average sales 
*/

select 
orderid,
sales,
round(avg(sales) over(),2) as average_sales,
round(sales - avg(sales) over(),2) as diff
from sales.orders;

/* 

6. Using the sales.orders table, display:

orderid
sales
the company's total sales
the percentage contribution of each order to the company's total sales
*/

select 
orderid,
sales,
sum(sales) over() as total_sales,
round((sales :: numeric/(sum(sales) over()))*100,2) as percent_contribution
from sales.orders;

/*
7. Using sales.orders, write a query to show:

orderid
customerid
sales
total sales per customer

*/

select 
orderid,
customerid,
sales,
sum(sales) over(partition by customerid) as total_sales_customer
from sales.orders;

/*
8. Using sales.orders, write a query to show:

orderid
customerid
sales
running total of sales per customer (ordered by orderid)
*/


select 
orderid,
customerid,
sales,
sum(sales) over(partition by customerid order by orderid asc rows between unbounded preceding and current row) as running_sales 
from sales.orders; 

/* 
9. Using sales.orders, write a query to show:

orderid
customerid
sales
next order’s sales for the same customer
*/

select 
orderid,
customerid,
sales,
lead(sales) over(partition by customerid order by orderid asc ) as next_order_sales
from sales.orders;