-- SQL practice 

/*
1.Using sales.customers, return:

firstname
lastname
country
score

Only customers whose score > 500.
*/
select 
firstname, 
lastname,
country, 
score
from sales.customers
where score>500;


/*
2.Using sales.customers, return all customers with:

firstname
lastname
country
score

Sort them by score from highest to lowest.
*/

select 
firstname, 
lastname, 
country, 
score
from sales.customers 
order by score desc;

/*
3.Using sales.customers, find customers who:

are from USA OR Germany
have a score
and have a score between 300 and 800 inclusive

Return:

id
first_name
country
score

Sort by score descending.
*/

select 
	customerid, 
	firstname, 
	country, 
	score 
from sales.customers 
where country in ('USA','Germany') and 
	score between 300 and 800 
order by score desc;



select
	c.customerid, 
	count(o.orderid) as number_of_orders,
	coalesce(sum(o.sales),0) as total_sales 
from sales.customers as c 
left join sales.orders as o
on c.customerid=o.customerid 
group by c.customerid 
order by total_sales desc ;

/*
5.Using sales.customers and sales.orders, find:

Each customer's total sales, but only show customers whose total sales are greater than 20.

Return:

customerid
first_name
total_sales

Sort by total_sales DESC.

Constraint: You must use GROUP BY and filter the aggregated result correctly.
*/

select 
c.customerid, 
c.firstname,
sum(o.sales) as total_sales 
from sales.customers as c 
inner join sales.orders as o 
on c.customerid = o.customerid 
group by c.customerid, 
			c.firstname
having sum(o.sales)>20
order by total_sales desc;

/*
6.Using:

sales.customers
sales.orders

For each customer who has at least one order, return:

customerid
firstname
total_orders
delivered_orders
delivered_percentage

Where:

delivered_percentage = delivered_orders / total_orders × 100

Round the percentage to 2 decimal places.

Sort by delivered_percentage DESC.

*/
-- Exploring Data Table 
select * from sales.orders;
-- Main logic
select
c.customerid, 
c.firstname,
count(o.orderid) as total_orders,
count(case 
		when o.orderstatus='Delivered' then 1
		end) as delivered_orders ,
round(count(case 
		when o.orderstatus='Delivered' then 1
		end)::numeric/ count(o.orderid) *100,2) as delivered_percentage
from sales.customers as c
inner join sales.orders as o 
on o.customerid=c.customerid
group by c.customerid,
		c.firstname
order by delivered_percentage desc;

