-- SQL SUB QUERY 

-- Find the prodcut that have a price higher than average price of all products 

select *
from(
	select 
	productid,
	price,
	avg(price) over() as avg_price
	from sales.products 
) table1
where price>avg_price;


-- Rank customers based on their total amount of sales

select *,
rank() over(order by total_sales desc) as customer_rank
from(
select
customerid,
sum(sales) total_sales
from sales.orders
group by customerid
)t 

-- Show the productid, names, prices and total number of orders.

select 
productid,
product,
price,
(select count(*)  from sales.orders) as total_orders
from sales.products;


-- Show all customer details and find the total orders of each customer


--Main Query
select 
c.*,
o.total_orders
from sales.customers as c
left join(
	select 
	customerid,
	count(*) total_orders
	from sales.orders
	group by customerid)  as o
on c.customerid=o.customerid;