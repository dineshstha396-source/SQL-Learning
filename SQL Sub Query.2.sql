-- SUB QUERY 

-- Find the products tha have a price higher than the average price of all products

-- Main query
select 
productid,
price 
from sales.products 
where price > (select avg(price) from sales.products)-- Sub Query;

-- Show the details of orders made by customers in Germany

--Exploring Data 
select * from sales.orders;
select * from sales.customers;

--Main Logic
select 
*
from sales.orders 
where customerid in (select customerid from sales.customers where country='Germany');


-- Show the details of orders made by customers who are not from  Germany

--Exploring Data 
select * from sales.orders;
select * from sales.customers;

--Main Logic
select 
*
from sales.orders 
where customerid not in (select customerid from sales.customers where country='Germany');

-- Find female employees whose salaries are greater than the salaries any males employees 

select 
employeeid,
firstname,
gender,
salary 
from sales.employees 
where salary > any (select salary from sales.employees where gender='M') and gender='F';


-- Find female employees whose salaries are greater than the salaries all males employees 

select 
employeeid,
firstname,
gender,
salary 
from sales.employees 
where salary > all (select salary from sales.employees where gender='M') and gender='F';


-- show the details of orders made by customers in Germany


select 
*
from sales.orders as o
where exists (select 1 from sales.customers as c
		where country='Germany' and o.customerid=c.customerid);
		
-- show the details of orders made by customers not in Germany

select 
*
from sales.orders as o
where not exists (select 1 from sales.customers as c
		where country='Germany' and o.customerid=c.customerid);





