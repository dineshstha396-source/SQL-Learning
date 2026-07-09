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

/* 5. Find all customers who have placed at least one order.

Expected output:
customerid
firstname
lastname
*/

select 
customerid,
firstname,
lastname
from sales.customers 
where customerid in (select customerid from sales.orders);


/* 6. Find all customers who have never placed an order.

Output:
customerid
firstname
lastname
*/

select 
customerid,
firstname,
lastname
from sales.customers
where customerid not in (select customerid from sales.orders where customerid is not null);

/* 7. Find all products whose price is greater than at least one product price in the Electronics category.

Output:
productid
product
price
*/

select 
productid, 
product, 
price 
from sales.products 
where price > any (select price from sales.products where category='Electronics');

/* 8. Find all products whose price is greater than all products price in the Electronics category.

Output:
productid
product
price
*/

select 
productid, 
product, 
price 
from sales.products 
where price > all (select price from sales.products where category='Electronics');

/*  
9. Show each product along with:

productid
product
price
average price of all products (as a column)
*/

select 
productid, 
product,
price,
(select avg(price) from sales.products) as average_price
from sales.products;

/* 10. Show each product and include:

productid
product
price
maximum price of all produc 
*/

select 
productid,
product, 
price,
(select max(price) from sales.products) as max_price
from sales.products;