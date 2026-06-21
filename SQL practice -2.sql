-- SQL practices 

/* 1. Using the sales.customers and sales.orders tables: 

Write a query to display : 
Customer ID 
First name 
and Order ID 

show only customers who have placed an order.*/

--Looking the table structure 
select * from sales.customers;
select * from sales.orders;


-- Here we need the customers who have placed an order.customers table has customerid
-- and orders table has it too who has placed order so we can use inner join to get the required data

select 
c.customerid,
c.firstname,
o.orderid
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;


/* 2. Display 
orderid , firstname,country and sales 

requirement 
- use inner join 
- show only orders placed by customers from germany 
- sort by sales in descending order.*/

select 
o.orderid,
c.firstname,
c.country,
o.sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
where country='Germany'
order by sales desc;


/* 3. Display firstname and number of orders 

requirements : 
- inlcude only customers who have placed orders 
-use inner join 
- count the number of order per customer 
- sort by number of orders descending */

select 
c.firstname,
count(o.orderid) as number_of_orders
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid, c.firstname
order by count(o.orderid) desc;


/* 4. Display customers who have never placed an order .
output 
customer id    firstname 
requirement : 
- use left join 
- do not use sub queries 
- do not use not in 
- return only customers with no matching order
*/

select 
c.customerid,
c.firstname 
from sales.customers as c
left join sales.orders as o 
on c.customerid = o.customerid 
where orderid is null


