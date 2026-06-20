-- SQL joins 

/* Get all customers along with their orders, but only for customers who have placed an order */

select 
	c.id, 
	c.first_name,
	o.order_id,
	o.sales
from customers as c
inner join orders as o
on  c.id =o.customer_id;

/* Get all customers along with their orders, including those without orders */

select 
c.id,
c.first_name,
o.order_id,
o.sales
from customers as c 
left join orders as o 
on c.id=o.customer_id;

/*Get all customers along with their orders, including orders 
without matchibg customers.*/

-- Here customers table is like a supporting table.

select 
c.id,
c.first_name,
o.order_id,
o.sales
from customers as c 
right join orders as o 
on c.id=o.customer_id;

--using left join 

select 
c.id,
c.first_name,
o.order_id,
o.sales
from  orders as o 
left join customers as c
on c.id=o.customer_id;


/* Get all customers and all orders , even if there's no match */

select 
c.id,
c.first_name,
o.order_id,
o.sales
from orders as o 
full join customers as c 
on c.id=o.customer_id;
