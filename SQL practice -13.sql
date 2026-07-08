-- SQL Practice 

/* 
1. Using sales.orders, write a query to show:

orderid
customerid
sales
previous order’s sales for the same customer
difference between current sales and previous sales

*/
select 
orderid,
customerid,
sales,
lag(sales) over(partition by customerid order by orderid) as previous_sales,
round(sales-lag(sales) over(partition by customerid order by orderid),2) as diff
from sales.orders;


/*
2. Using sales.orders, write a query to show:

orderid
customerid
sales
next order’s sales for the same customer
difference: next sales - current sales

*/

select 
orderid,
customerid,
sales,
lead(sales) over(partition by customerid order by orderid) as next_sales,
round(sales-lead(sales) over(partition by customerid order by orderid),2) as diff
from sales.orders;


/* 3. Using sales.orders, write a query to show:

orderid
customerid
sales
first sale value for each customer
*/

select 
orderid,
customerid,
sales,
first_value(sales) over(partition by customerid order by orderid) as first_sales
from sales.orders;

/* 4. Using sales.orders, write a query to show:

orderid
customerid
sales
last sales value for each customer
*/

select 
orderid,
customerid,
sales,
last_value(sales) over(partition by customerid order by orderid rows between current row and unbounded following) as last_sales
from sales.orders;

/* 5. Using sales.orders, write a query to show:

orderid
customerid
sales
second highest sales value per customer (based on orderid sequence)

*/
select 
orderid,
customerid,
sales,
lead(sales,1) over(partition by customerid order by orderid)
from sales.orders;


/* 6. Using sales.orders, write a query to show:

orderid
customerid
sales
customer’s total sales
percentage contribution of each order to customer’s total sales
rank of each order by sales within customer
*/

select 
orderid,
customerid,
sales,
sum(sales) over(partition by customerid) as total_customer_sales, 
round((sales :: numeric/sum(sales) over(partition by customerid))*100,2) as percentage,
rank() over(partition by customerid order by sales desc) as rank_customer_sales
from sales.orders;

/* 7. 
Using sales.orders, write a query to show:

orderid
customerid
sales
average sales per customer
difference between each order’s sales and customer average
*/

select 
orderid,
customerid,
sales,
round(avg(sales) over(partition by customerid),2) as average_sales,
round(sales-avg(sales) over(partition by customerid),2) as diff
from sales.orders;


/*
8 . Using sales.orders, write a query to show:

orderid
customerid
sales
rank of each order within customer based on sales (highest first)
also show total number of orders per customer
*/

select 
orderid,
customerid,
sales, 
rank() over(partition by customerid order by sales desc ) as rank_customers,
count(orderid) over(partition by customerid) as total_orders
from sales.orders;

/* 
9. Using sales.orders, write a query to show:

orderid
customerid
sales
previous order’s sales (within customer)
current sales minus previous sales
*/

select 
orderid,
customerid,
sales,
lag(sales) over(partition by customerid order by orderid) as previous_order_sales,
sales-lag(sales) over(partition by customerid order by orderid) as difference
from sales.orders;

/* 10 . Using sales.orders, write a query to show:

orderid
customerid
sales
next order’s sales within each customer
difference: next sales − current sales
also show row number of each order within customer based on order sequence

*/

select 
orderid, 
customerid,
sales,
lead(sales) over(partition by customerid order by orderid ) as next_order,
lead(sales) over(partition by customerid order by orderid ) - sales as difference ,
row_number() over(partition by customerid order by orderid) as rw_no 
from sales.orders;