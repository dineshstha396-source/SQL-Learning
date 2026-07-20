-- SQL practice 

--Stage 1: Basic Query syntax

--1. Select all columns from customers 

select * from sales.customers;

--2. Select only firstname adn lastname

select 
firstname,
lastname
from sales.customers;

--3. Rename firstname as first_name 

select 
firstname as first_name 
from sales.customers; 

--4. Remove duplicate countries 

select 
distinct(country)
from sales.customers;

--5. Select the first 10 rows 

select 
customerid,
firstname, 
lastname , 
score 
from sales.customers 
limit 10;


-- Stage 2: FIltering Syntax (Where)

--6. Find customers from Germany
select 
customerid,
firstname,
country,
score 
from sales.customers 
where country='Germany';

--7. Find products with price greater than 500. 

select 
productid,
products , 
price 
from sales.products 
where price > 500 ; 

--8. Find the orders beteem two dates 

select 
orderid,
orderdate,
sales
from sales.orders 
where orderdate between '2024-01-01' and '2026-01-01'

--9. Find customers form Germany or the USA 

select 
customerid,
firstname,
country 
from sales.customers 
where country='USA'or country ='Germany';

--10. FInd employees whose salary is not equal to 5000.

select 
employeeid, 
firstname,
salary 
from sales.employees
where salary <> 5000;

--11. FInd customers whose last name starts with s 

select 
customerid,
firstname,
lastname,
score 
from sales.customers 
where lastname like 'S%';

--12. Find products whose category is in a given list 

select 
productid, 
product, 
category ,
price 
from sales.products 
where category in ('Accessories','Technology');

--13. FInd order with null sales

select 
orderid , 
sales 
from sales.orders 
where sales is null ;

--Stage 3: Sorting and grouping syntax

--14. Sort customers by country 

select 
customerid,
firstname,
country, 
score 
from sales.customers 
order by country asc; 

--15. Sort products by price in descending order. 

select 
productid, 
product, 
price 
from sales.products 
order by price desc; 

-- 16. Count the total number of customers ; 

select 
count(customerid) as customer_count
from sales.customers ; 

-- 17. Find the number of customers in each country 

select 
country,
count(customerid) as customer_count
from sales.customers 
group by country ; 

--18. FInd the average salary by department 

select 
department, 
round(avg(salary),2) as avg_salary
from sales.employees 
group by department ; 

--19. Find department having more than 5 employees 

select 
department, 
count(employeeid) as employee_count_per_dep
from sales.employees 
group by department
having count(employeeid)>5;





