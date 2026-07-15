-- SQL String and Number functions 


--1. Display all customer first names in uppercase 

select 
upper(firstname) as Upper_firstname
from sales.customers;

--2. Display all employee last names in lowercase

select 
lower(lastname) as lower_lastname
from sales.employees;

--3. Show customer full names using concat()

select 
concat(firstname,' ',lastname) as full_name
from sales.customers;

--4. Display the length of each product name

select 
length(product) as length_of_product
from sales.products;

--5. Display the first 3 characters of every product name 

select 
left(product,3) as three_char_product
from sales.products;

--6. Display the last 4 character of every product name 

select 
right(product,4) as last_four_char_product
from sales.products;

--7. Replace all spaces in products name with underscore

select 
replace(product,' ','_') as modified 
from sales.products;

--8. Display customer names after removing extra spaces using trim()

select 
trim(firstname) as trimed_name
from sales.customers;

--9. Find customers whose first name starts with 'A'

--1st solution
select 
firstname
from sales.customers 
where firstname like 'A%';

--2nd solution

select 
firstname
from sales.customers 
where left(firstname,1)='A';

--10. Find products whose last two letters are 'er'/ 

select 
product
from sales.products 
where right(product,2)='er';

--11. Display the first 2 letters of employee department 

select 
department,
left(department,2) as short_name
from sales.employees;

--12. Find products whose name contain more than 10 charcters 

select 
productid,
product 
from sales.products 
where length(product)>10;

-- 13. Display customer initials
select 
concat(substring(firstname,1,1),'',substring(lastname,1,1)) as customer_initials
from sales.customers;

--14. Display employees in this format : Smith, John

select 
concat(firstname,', ',lastname) as employee_name
from sales.employees;

--15. Find customers whose country names are completely uppercase.
select
customerid,
firstname,
country
from sales.customers
where country=upper(country);

--16. Round product price to the nearest integer

select 
productid,
product,
round(price,0) as rounded_price
from sales.products;

--17. Round product price to 2 decimal places 

select 
productid,
product,
round(price,2) as rounded_prices
from sales.products;

--18. Show the absolute value of -150,-300,-25 

select 
abs(-150) as absolute_value1,
abs(-300) as absolute_value2,
abs(-25) as absolute_value3;

--19. Display product prices round up using ceil()

select 
productid,
product,
ceil(price)
from sales.products;

--20. Display product prices round down using floor()

select 
productid,
product,
floor(price)
from sales.products;

--21. Find products whose prices are even numbers.

select 
productid,
product,
price
from sales.products 
where mod(price,2)=0;

--22. Find products whose prices are odd numners 

select 
productid,
product,
price 
from sales.products 
where mod(price,2)!=0;

--23. Display products with 10% discount 

select 
productid,
product,
price as original_price ,
round(price*0.9,2) as discount_price
from sales.products;


--24. Increase every employee salary by 15%

select 
employeeid,
firstname,
salary as original_salary,
round(salary*1.15) as increased_price
from sales.employees;

--25. Find Products whose rounded price is greater than 500.

select 
product,
price
from sales.products 
where round(price)>500;

--26. Count how many customers belong to each country, displaying country names in uppercase

select
upper(country),
count(customerid) as customer_count
from sales.customers
group by country;

--27. Find departments whose average salary is greater then 50000.

select 
department
from sales.employees
group by department 
having round(avg(salary))>50000;

--28. Show categories and average product price rounded to two decimals 

select 
category,
round(avg(price),2) as rounded_avg_price
from sales.products
group by category;


--29. Display employee full names and salary rounded to the nearest thousand.

select 
employeeid,
concat(firstname,' ',lastname) as full_name,
round(salary/1000)*1000 as rounded_salary
from sales.employees