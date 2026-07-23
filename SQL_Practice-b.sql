-- SQL Practice 

--Stage 1: Basic Query Syntax (15 Questions)

--1. Display all columns from customers 

select 
* 
from sales.customers; 

--2. Display only firstname, lastname and country 

select 
firstname, 
lastname, 
country 
from sales.customers; 

--3. Rename firstname → first_name and lastname → last_name

select 
firstname as first_name, 
lastname as last_name 
from sales.customers; 

--4. Find all uniques countries from customers 

select distinct 
country 
from sales.customers; 

--5. Display customers whose score is greater than 500. 

select 
customerid, 
firstname, 
country , 
score 
from sales.customers 
where score> 500;

--6. Find customers from USA, Germany , Canada 

select 
customerid , 
firstname, 
country 
from sales.customers 
where country in ('Germany','Canada','USA');

--7. Find products where price is between 50 and 200. 

select 
product, 
category ,
price
from sales.products
where price between 50 and 200;

--8. Find customers whose first name starts with 'A'

select 
customerid, 
firstname, 
score 
from sales.customers 
where firstname like 'A%';

--9. Display top 10 highest priced products

select 
product, 
price 
from sales.products 
order by price desc
limit 10;

-- 10. Find employees who are male and salary greater than 60000.

select 
employeeid, 
firstname , 
gender,
salary 
from sales.employees
where gender='M' and salary > 60000;

--11. Find orders placed after 2025-01-01

select 
orderid, 
sales,
orderdate
from sales.orders 
where orderdate > '2025-01-01';

--12. Display customers where score is NULL

select 
customerid , 
firstname,
score 
from sales.customers 
where score is NULL;

--13. Replace NULl scores with 0 .

select 
customerid, 
firstname, 
coalesce(score,0) as score
from sales.customers; 

--14. Display customers ordered by score descending 

select 
customerid, 
firstname,
score 
from sales.customers 
order by score desc;

--15. Display the 5 cheapest products 

select 
product,
price 
from sales.products 
order by price asc 
limit 5; 


-- Stage 2: Aggregate Logic (15 Questions)

--16. Count total customers 

select 
count(customerid) as customer_count
from sales.customers ;

--17. Find average customer score 

select 
round(avg(coalesce(score,0)),2) as avg_customer_score 
from sales.customers; 

--18. Find maximum product price 

select 
max(price) as max_product_price
from sales.products;

--19. Find minimum employee salary
select 
min(salary) as min_emp_salary 
from sales.employees;

-- 20. Calculate total sales from orders 

select 
sum(sales) as total_sales
from sales.orders; 

-- 21. Find total customers per country 

select 
country,
count(customerid) as customer_count
from sales.customers 
group by country;

-- 22. Find the average score by country

select 
country, 
round(avg(coalesce(score,0)),2) as average_score
from sales.customers 
group by country;

--23. Find total sales by order status 

select 
orderstatus, 
sum(sales) as total_sales
from sales.orders 
group by orderstatus; 

--24. Find number of products in each category 

select 
category,
count(productid) as product_count
from sales.products
group by category;

-- 25. Find categories having more than 5 products 

select 
category, 
count(productid) as product_count
from sales.products 
group by category
having count(productid)>5;


--26.  Find countries where average score is above 500;

select 
country, 
round(avg(coalesce(score,0)),2) as avg_score
from sales.customers 
group by country 
having avg(coalesce(score,0))>500;

--27. Find highest salary department wise 
select 
department, 
max(salary) as highest_salary 
from sales.employees
group by department; 

--28. Find total sales by year 

select 
extract(year from orderdate) as year_time,
sum(sales) as total_sales
from sales.orders
group by extract(year from orderdate);


--29. Find monthly sales 

select 
to_char(orderdate,'YYYY-MM') as year_month,
sum(sales) as total_sales
from sales.orders 
group by to_char(orderdate,'YYYY-MM')
order by year_month asc;

--30. Find the average salary of each department and display departments from highest average salary to lowest.
select 
department,
round(avg(coalesce(salary,0)),2) as avg_salary 
from sales.employees
group by department
order by avg_salary desc;


--Stage 3: CASE + NULL + Functions (15 Questions)

/* 
31. Create customer segment : 
score >= 700 → High
score 400-699 → Medium
below 400 → Low
*/

select 
	customerid, 
	firstname, 
	case 
		when score >= 700 then 'High'
		when score >=400 then 'Medium'
		else 'Low'
	end as customer_segment
from sales.customers;

-- 32. Replace NULL country with 'Unknown'

select 
customerid,
firstname,
coalesce(country,'Unknown') as Country 
from sales.customers ;


/*
33. Create salary category:

salary > 80000 → Senior
salary 50000-80000 → Mid
else Junior
*/

select 
employeeid, 
firstname,
case 
	when salary > 80000 then 'Senior'
	When salary >= 50000 then 'Mid'
	else 'Junior'
end as Salary_category
from sales.employees ;

--34. Display employee full Name 

select 
concat(firstname,' ',lastname) as full_name
from sales.employees;

--35. Convert all customer names into uppercase 

select 
customerid, 
upper(firstname) as customer_name
from sales.customers; 

--36. Find length of product names 

select 
product, 
length(product) as product_length
from sales.products;

--37. Extract year from orderdate 

select 
orderid,
sales,
extract(year from orderdate) as year_time
from sales.orders;

--38. Extract month from order date 

select 
orderid, 
extract(month from orderdate) as month_time 
from sales.orders;

--39. Find orders shipped after 7 days 

select 
orderid, 
sales 
from sales.orders 
where (shipdate-orderdate)>7;

--40. Round product prices to nearest integer. 

select 
product , 
round(price)
from sales.products;

--41. Calculate discounted price assuming 10% disount 

select 
orderid, 
sales, 
round(sales - sales*0.1,2) as discounted_price 
from sales.orders; 

--42. Find products with names containing 'Phone'

select 
product, 
price 
from sales.products
where product ilike '%phone%';


--43. Trim spaces from customer names 

select 
customerid, 
trim(firstname) as trimmed_name
from sales.customers ;

--44. Find employees born after 1995 

select 
employeeid, 
firstname,
salary
from sales.employees
where extract(year from birthdate)>1995;

/* 
Create order priority:

sales > 10000 → High
sales 5000-10000 → Medium
else Low
*/

select 
orderid, 
sales,
case 
	when sales>10000 then 'High'
	when sales>=5000 then 'Medium'
	else 'Low'
end as order_priority 
from sales.orders;


--Stage 4: JOIN Mastery (20 Questions)

/*
46. Join customers and orders table 
Display:

customerid
firstname
orderid
sales
*/

select 
c.customerid, 
c.firstname,
o.orderid,
o.sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;


-- 47. Find all customers with their orders including customer without orders 

select 
c.customerid, 
c.firstname,
o.orderid,
o.sales
from sales.customers as c 
left join sales.orders as o 
on c.customerid=o.customerid;

-- 48. Find total sales generated by each customer. 

select 
c.customerid, 
c.firstname,
sum(o.sales) as total_sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname
order by total_sales desc;

-- 49. Find customers who never places and order. 

select 
c.customerid, 
c.firstname,
o.orderid,
o.sales
from sales.customers as c 
left join sales.orders as o 
on c.customerid=o.customerid
where o.customerid is null;

/*
50.Join products and orders.

Display:

product
orderid
sales
*/

select 
p.product,
o.orderid,
o.sales
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid;

--51 . Find total revenue per product 

select 
p.product,
sum(o.sales) as total_revenue
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid
group by p.product
order by total_revenue desc;

--52. Find the best selling product

select 
p.product,
sum(o.sales) as total_revenue
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid
group by p.product
order by total_revenue desc
limit 1;

--53. Find sales by product category 

select 
p.category,
sum(o.sales) as total_sales_per_category
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid
group by p.category
order by total_sales_per_category desc;


/*
54. Join employees and orders 
Display:

employee name
orderid
sales

*/

select 
e.firstname,
o.orderid,
o.sales
from sales.employees as e 
inner join sales.orders as o 
on e.employeeid=o.salespersonid;

--55. Find total sales generated by each salesperson 


select 
e.employeeid,
e.firstname,
sum(o.sales) as total_sales
from sales.employees as e 
inner join sales.orders as o 
on e.employeeid=o.salespersonid
group by e.employeeid,e.firstname;

-- 56. FInd employees who have no sales


select 
e.firstname,
o.orderid,
o.sales
from sales.employees as e 
left join sales.orders as o 
on e.employeeid=o.salespersonid
where o.salespersonid is null;


/* 
57. Join customer + orders + products
Show:

customer name
product
sales
*/

select 
c.firstname,
p.product,
o.sales
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid
inner join sales.products as p 
on p.productid=o.productid;


-- 58. Find highest spending customer.

select 
c.customerid,
c.firstname,
sum(o.sales) as total_sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname
order by total_sales desc
limit 1;


--59. Find the most purchased category 

select 
p.category, 
count(o.orderid) as order_count
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid
group by p.category 
order by order_count desc
limit 1; 

--60. Find monthly revenue by category 

select 
category,
to_char(o.orderdate,'YYYY-MM') as year_month,
sum(o.sales) as total_sales
from sales.products as p 
inner join sales.orders as o 
on o.productid=p.productid 
group by category,to_char(o.orderdate,'YYYY-MM')
order by category,to_char(o.orderdate,'YYYY-MM');

-- 61. Find customers who purchased electronics 

select 
c.customerid, 
c.firstname, 
p.category 
from sales.orders as o 
inner join sales.customers as c 
on o.customerid=c.customerid
inner join sales.products as p 
on o.productid=p.productid
where p.category ='Electronics';


--62. Find products that was never ordered 

select 
p.productid,
p.product ,
o.orderid,
o.sales
from sales.products as p 
left join sales.orders as o 
on p.productid=o.productid
where o.productid is null;

--63. Find employees ranked by sales 

select 
e.employeeid, 
e.firstname,
sum(o.sales) as total_sales
from sales.employees as e
inner join sales.orders as o 
on e.employeeid=o.salespersonid
group by e.employeeid,e.firstname
order by total_sales desc;

-- 64 . Find customer order count.

select 
c.customerid,
c.firstname,
count(o.orderid) as order_count
from sales.orders as o 
inner join sales.customers as c
on c.customerid=o.customerid 
group by c.customerid,c.firstname;


-- 65. Find average order value per customer.

select 
c.customerid, 
c.firstname, 
round(avg(coalesce(o.sales,0)),2) as avg_order_value
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname;

-- Stage 5: Set Operations (10 Questions)


--66. Combine customer countries and employee departments.

select 
country 
from sales.customers 
union -- this gives unique values  
select 
department 
from sales.employees; 


-- 67. Display all unique first names from both customers and employees.

select 
firstname 
from sales.customers 
union 
select 
firstname 
from sales.employees;

--68. Display all first names from both customers and employees, including duplicates.

select 
firstname 
from sales.customers 
union all 
select 
firstname 
from sales.employees;


-- 69. Find customer first names that do not exist in employees.

select 
firstname 
from sales.customers 
except 
select 
firstname 
from sales.employees;

--70. Find first names that exist in both customers and employees.

select 
firstname 
from sales.customers 
intersect
select 
firstname 
from sales.employees;

-- Stage 6: Window Functions (25 Questions)

-- 71. Rank customers by score

select 
rank() over(order by score desc),
customerid, 
firstname,
score 
from sales.customers ;

--72. Rank products by price within category.

select 
category, 
product,
rank() over(partition by category order by price desc),
price
from sales.products;


--73. Number the products within each category from the most expensive to the least expensive.

select 
category, 
product,
row_number() over(partition by category order by price desc),
price
from sales.products;

--74. Rank customers based on their score. Customers with the same score should receive the same ranking.

select 
customerid,
firstname,
rank() over(order by score desc)
from sales.customers;


--75. Rank employees by salary within each department.

select 
employeeid,
department,
firstname,
rank() over(partition by department order by salary desc),
salary
from sales.employees;

--76. Divide customers into four approximately equal groups based on their score.

select 
customerid,
firstname,
score,
ntile(4) over(order by score desc) as bucket
from sales.customers;

--77. For each customer, determine the relative position of their score compared to all other customers as a percentage.

select 
customerid, 
firstname, 
score, 
percent_rank() over(order by score desc)
from sales.customers;

-- 78. . For each customer, determine the proportion of customers whose scores are less than or equal to that customer's score.

select 
customerid, 
firstname, 
score, 
cume_dist() over(order by score desc)
from sales.customers;

--79 . Display each customer's order along with the sales amount from their previous order.

select 
orderid, 
sales,
lag(sales) over(PARTITION BY customerid
ORDER BY orderdate) as previous_sales
from sales.orders;

--80. . Display each customer's order along with the sales amount from their next order.

select 
orderid, 
sales,
LEAD(sales)
OVER(
PARTITION BY customerid
ORDER BY orderdate
)
from sales.orders;

--81. Display each customer's orders and show the cumulative sales after every order.

select 
orderid, 
sales,
sum(sales) over( partition by customerid order by orderdate  rows between unbounded preceding and current row )
from sales.orders;

--82. Display each customer's orders and show the cumulative average sales after every order.

select 
orderid, 
sales,
round(avg(coalesce(sales,0)) over( partition by customerid order by orderdate rows between unbounded preceding and current row ),2) as cum_avg
from sales.orders;

--83. For every order, display the first order date of that customer.

select 
orderid,
customerid,
first_value(orderdate) over(partition by customerid order by orderdate) as first_order_date
from sales.orders;

--84. For every order, display the most recent order date of that customer.

select 
orderid,
customerid,
last_value(orderdate) over(partition by customerid order by orderdate rows between unbounded preceding and unbounded following) as latest_orderdate
from sales.orders;


-- 85. For every order, display the second order date of that customer.

select 
orderid,
customerid,
nth_value(orderdate,2) over(partition by customerid order by orderdate rows between unbounded preceding and unbounded following ) as second_order_date
from sales.orders;
