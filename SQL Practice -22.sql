-- SQL Practice 

/* 1. 
Find all customers whose total sales are greater than the average total sales of all customers.
*/
select 
c.customerid, 
concat(c.firstname,' ',c.lastname) as full_name,
sum(o.sales) as total_sales
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid 
group by c.customerid
having sum(o.sales)>(
select avg(customer_total_sales) from 
(
select
customerid,
sum(sales) as customer_total_sales 
from sales.orders 
group by customerid
)t)

/* 2. Find all products whose price is greater than the average price of all products.
*/

select 
productid,
product,
price 
from sales.products 
where price > (select avg(price) from sales.products)

/* 3.Find customers who have placed more orders than the average number of orders placed by customers.
*/

select 
c.customerid,
concat(c.firstname,' ',c.lastname) as full_name,
count(o.orderid) as total_orders 
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.lastname
having count(o.orderid)>
	( select 
			avg(total_orders)
			from (
					select 
						count(orderid) as total_orders
					from sales.orders
					group by customerid
					)
	)