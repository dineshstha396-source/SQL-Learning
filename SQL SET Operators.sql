--SQL Set operators

/* 
Combine the data from employees and customers into one table */

--Exploring table data 
select * from sales.employees;

select * from sales.customers;

--Main logic 

select 
firstname,
lastname
from sales.customers
union 
select 
firstname,
lastname
from sales.employees;

/* 
Combine the data from employees and customers into one table
including duplicates */

--Exploring table data 
select * from sales.employees;

select * from sales.customers;

--Main logic 

select 
firstname,
lastname
from sales.customers
union all 
select 
firstname,
lastname
from sales.employees;


/* Find employees who are not customers at the same time */

select 
firstname,
lastname
from sales.employees
except 
select 
firstname,
lastname
from sales.customers;


/* Find the Employees who are also customers */

select 
firstname,
lastname
from sales.customers
intersect
select 
firstname,
lastname
from sales.employees;

/* Orders are stored in seperate tables (orders and ordersarchive).
Combine all orders into one report without duplicates. */

--Exploring data 
select * from sales.orders;
select * from sales.ordersarchive;

-- Main logic : 

select 
'Orders' as source_table,
orderid,
productid,
customerid,
salespersonid,
orderdate,
shipdate,
orderstatus,
shipaddress,
billaddress,
quantity,
sales,
creationtime
from sales.orders
union
select 
'Orderarchive' as source_table,
orderid,
productid,
customerid,
salespersonid,
orderdate,
shipdate,
orderstatus,
shipaddress,
billaddress,
quantity,
sales,
creationtime
from sales.ordersarchive;