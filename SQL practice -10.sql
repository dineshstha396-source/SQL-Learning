-- SQL practice 

--Level 1 – Basic Window Aggregate Functions

/* 1. Show the total company sales on every row*/
select 
orderid,
productid,
sales,
sum(sales) over() as total_sales
from sales.orders;

/* 2. Show average sales across all orders beside every order*/

select 
orderid,
sales,
avg(sales) over() average_sales
from sales.orders;

/* 3. Show  maximum sales beside every order*/

select 
orderid,
sales,
max(sales) over() max_sales
from sales.orders;


/* 4. Show minimum sales beside every order*/

select 
orderid,
sales,
min(sales) over() min_sales
from sales.orders;


/* 5. Show  total number of orders beside every row  */

select 
orderid,
sales,
count(orderid) over() total_orders
from sales.orders;

--Level 2 – PARTITION BY

/* 6. Find total sales made by each customer.*/

select 
customerid,
orderid,
sales,
sum(sales) over(partition by customerid) as customer_total_sales
from sales.orders;

/* 7. Find the average sales for each customers*/

select 
customerid,
orderid,
sales,
avg(sales) over(partition by customerid) as avg_sales
from sales.orders;

/* 8. Find maximum sales for each salesperson */

select 
salespersonid,
orderid,
sales,
max(sales) over(partition by salespersonid) 
from sales.orders;

/* 9. Find the minimum sales for each product */

select 
productid,
sales,
min(sales) over(partition by productid)
from sales.orders;

/* 10. Count how many orders each customers has placed */

select 
customerid,
orderid,
count(orderid) over(partition by customerid) as orders
from sales.orders;

-- Level 3 – Multiple Columns

/* 11. Find total sales for each customer and order status */

select 
customerid,
sum(sales) over(partition by customerid,orderstatus) as total_sales,
orderstatus
from sales.orders;

/* 12. Count orders for each salesperson and order status */

select 
salespersonid,
count(orderid) over(partition by salespersonid,orderstatus) as count_orders_salesperson,
orderstatus
from sales.orders;

/* 13. Find average sales for every product category */

select 
p.product,
p.category,
o.sales,
avg(o.sales) over(partition by p.category) as category_average_sales
from sales.orders as o 
inner join sales.products as p 
on o.productid=p.productid;
