-- SQL Practice 

/* 1. Show all products that have a price greater than the average price of all products.

Expected output:

productid
product
price
*/

select 
productid,
product,
price
from sales.products
where price> (select avg(price) from sales.products) ;

/* 2. Show the employees who earn the second highest salary.

Expected output:

employeeid
firstname
lastname
salary

*/

select 
employeeid,
firstname,
lastname,
salary 
from sales.employees 
where salary=
(select
max(salary)
from sales.employees 
where salary < (select max(salary) from sales.employees )
);


/* 3. Show all products whose price is equal to the cheapest product price.

Expected output:

productid
product
price
*/

select 
productid,
product,
price 
from sales.products 
where price =( select min(price) from sales.products);

/* 4. Find all employees whose salary is greater than the average salary of their department.

Output:
employeeid
firstname
lastname
department
salary

*/

-- Exploring data

select  * from sales.employees;

-- Main logic
select 
employeeid,
firstname,
lastname,
department, 
salary 
from sales.employees as e1
where salary > (select avg(salary) from sales.employees  as e2  where e1.department=e2.department)