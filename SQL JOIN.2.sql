-- SQL :Advanced SQL Joins

/* Get all customers who haven't place any order */

select 
*
from customers as c 
left join orders as o 
on c.id=o.customer_id
where o.customer_id is null;


/* Get all orders without matching customers */

-- using right anti join
select 
*
from customers as c
right join orders as o 
on c.id=o.customer_id 
where c.id is null

-- using left anti join 

select 
*
from orders as o
left join customers as c
on c.id=o.customer_id 
where c.id is null

/* 
Find the customers without orders and orders without customers */

select 
* 
from customers as c 
full join orders as o 
on c.id=o.customer_id
where c.id is null or o.customer_id is null

/* Get all customers along with their orders , but 
only for customers who has placed an order (Note :without using inner join)*/

select 
*
from customers as c 
left join orders as o 
on c.id=o.customer_id
where o.customer_id is not null;


/* Generate all possible combinations of customers and orders */

select 
*
from customers 
cross join orders;


/* Using SalesDB , retrieve a list of all orders , along with 
the related customers , product and employee details */

-- checking data (table) structure 

select * from sales.customers;

select * from sales.products;

select * from sales.orders;

select * from sales.employees;

select 
o.orderid,
c.firstname as customer,
p.product,
o.sales,
p.price,
e.firstname as salesperson
from sales.orders as o 
left join sales.customers as c 
on c.customerid =o.customerid
left join sales.products as p 
on p.productid=o.productid
left join sales.employees as e
on e.employeeid=o.salespersonid;