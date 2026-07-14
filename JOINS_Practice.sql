-- SQL JOINS

-- 1. Show order id , customer first name, customer country  from the orders table 

select 
o.orderid,
c.firstname,
c.country 
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;

--2. Show product name, category, sales amount for every order 

select 
p.product,
p.category ,
o.sales 
from sales.products as p 
inner join  sales.orders as o 
on p.productid = o.productid ;

--3. Show all orders made by customers from Germany 

select 
o.orderid,
c.firstname,
c.country, 
o.sales
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid
where c.country='Germany';

--4. Show all customers and their orders. Note : include customers who never ordered 

select 
c.customerid,
c.firstname,
o.orderid,
o.sales
from sales.customers as c 
left join  sales.orders as o 
on c.customerid=o.customerid; 

--5. Show all products and the orders associated with them and include products wiith no orders 

select 
p.product, 
p.category,
o.orderid
from sales.products as p 
left join sales.orders as o
on o.productid=p.productid;


--6. Find customers who never placed an order.

select 
c.customerid,
c.firstname,
c.country 
from sales.customers as c 
left join sales.orders as o 
on c.customerid=o.customerid
where o.customerid is NULL;

--7. Show all orders together with customer names . include orders even if the customer record is missing 

select 
o.orderid,
c.firstname,
o.sales
from sales.customers as c
right join sales.orders as o 
on c.customerid=o.customerid;

--8. Show all orders and product names . include every order 

select 
o.orderid,
p.product,
o.sales
from sales.products as p 
right join sales.orders as o 
on p.productid=o.productid;

--9. Show all customers and all orders 
select 
c.customerid,
c.firstname,
o.orderid,
o.sales
from sales.customers as c
full join sales.orders as o 
on c.customerid=o.customerid;

--10. Show all product and all orders 

select 
p.productid,
p.product, 
o.orderid,
o.sales
from sales.products as p 
full join sales.orders as o 
on p.productid=o.productid;

--11. Show orderid, customer name , product name and sales 

select 
o.orderid, 
c.firstname, 
p.product,
o.sales
from sales.orders as o 
inner join sales.customers as c
on c.customerid=o.customerid
inner join sales.products as p 
on p.productid=o.productid;

-- 12. Show orderid,customer name , product category and sales only for customers from USA

select 
o.orderid,
c.firstname,
p.category,
o.sales
from sales.orders as o 
left join sales.customers as c 
on c.customerid=o.customerid
left join sales.products as p 
on p.productid=o.productid 
where c.country='USA';
-- If you use LEFT JOIN and then put a condition on the right table in the WHERE clause, the query often behaves like an INNER JOIN.