-- SQL Practice 

/* 1. Find Products whose pricce is greater than the average price of their category */

select 
	p1.productid,
	p1.product,
	p1.price,
	p1.category 
from 
sales.products as p1
where p1.price >(
select 
	Avg(p2.price)
	from sales.products as p2
	where p2.category=p1.category
);

/* 2. Find all customers who have placed at least one order.

Output:
customerid
firstname
lastname
*/

select 
c1.customerid,
c1.firstname,
c1.lastname 
from sales.customers as c1
where exists(
	select 
	1
	from sales.orders as o
	where c1.customerid=o.customerid
)

/* 3. Find all customers who have never placed an order.
*/

select 
c1.customerid,
c1.firstname,
c1.lastname 
from sales.customers as c1
where not exists(
	select 
	1
	from sales.orders as o
	where c1.customerid=o.customerid
)

/* 4.Find all customers who have placed at least one order with sales > 100. */

select 
c1.customerid,
c1.firstname,
c1.lastname
from sales.customers as c1
where (exists(
	select 1
	from sales.orders as o 
	where c1.customerid=o.customerid 
	and (o.sales>100)
) );

/* 5. Find customers who have at least one order placed after '2021-06-01'. */


select 
c1.customerid,
c1.firstname,
c1.lastname 
from sales.customers as c1
where exists(
	select 
	1
	from sales.orders as o
	where c1.customerid=o.customerid
	and o.orderdate > '2021-06-01'
)

/* 6.Find all products that have never been ordered. */

select 
p.productid,
p.product,
p.category 
from sales.products as p 
where not exists (
	select 1
	from sales.orders as o 
	where p.productid=o.productid
)

/* 7.Find all products that has at least one order with sales greater than 100. */

select 
p.productid,
p.product,
p.category 
from sales.products as p 
where exists (
	select 1
	from sales.orders as o 
	where p.productid=o.productid
	and o.sales>100
)

/* 8. Find customers who have placed at least two orders.
Output
customerid
firstname
lastname
*/


select 
c.customerid,
c.firstname,
c.lastname
from sales.customers as c 
where exists(
	select 1 
	from sales.orders as o 
	where o.customerid=c.customerid 
	group by o.customerid
	having (count(o.orderid) )>=2
)

