-- SQL Practice 

--Section A — Filtering & Business Logic (20)

-- 1. Display customers whose score is between 400 and 700 and who are not from Germany 

select 
	customerid, 
	firstname, 
	country, 
	score
from sales.customers 
where score between 400 and 700 
		and country<> 'Germany';

--2. Display products costing either less than 50 or more than 500

select 
productid, 
product, 
category , 
price 
from sales.products 
where price not between 50 and 500;

--3. Find employees whose salary is between 40000 and 70000 and who belong to the Sales department 

select 
employeeid, 
firstname, 
department, 
salary 
from sales.employees 
where salary between 40000 and 70000 
	and department='Sales';

--4. Display orders placed during the first quarter of any year 

select 
orderid, 
orderdate, 
sales
from sales.orders 
where extract(quarter from orderdate)=1;

--5. Find customers whose first name contains the letter "a" anywhere 

select 
customerid, 
firstname, 
country, 
score
from sales.customers 
where firstname like '%a%';

--6. Display products whose names end with "Pro".

select 
productid, 
product, 
category, 
price 
from sales.products 
where product like '%Pro';

--7. Display customers with missing scores but known countries 

select 
	customerid,
	firstname, 
	country, 
	score
from sales.customers 
where score is null 
	and country is  not null;

--8. Display orders that have not yet been shipped;

select 
orderid, 
orderdate, 
shipdate, 
sales
from sales.orders 
where shipdate is null;

--9. Display employees whose manager is assigned 

select 
employeeid, 
firstname,
managerid, 
salary 
from sales.employees 
where managerid is not null;


-- 10. Display employees who do not have a manager

select 
employeeid, 
firstname,
managerid, 
salary 
from sales.employees 
where managerid is  null;


--11. Find products whose category is Electronics or Furniture 

select 
product, 
category, 
price 
from sales.products 
where category in ('Electronic','Furniture');

--12. Display customers whose score is exactly 500,600 or 700

select 
customerid, 
firstname, 
score 
from sales.customers
where score in (500,600,700);

--13. Find orders placed on weekends 

select 
orderid, 
orderdate, 
to_char(orderdate,'Day') as weekends,
sales
from sales.orders 
where extract(dow from orderdate) in (0,6);

--14. Display products whose price is not between 100 and 300 

select 
product, 
category, 
price 
from sales.products 
where price  not between 100 and 300;


--15. Find employees born before 1990

select 
employeeid, 
firstname, 
birthdate,
salary
from sales.employees 
where extract(year from birthdate) < 1990;

--16. Display customers whose last name starts with "S"

select 
customerid, 
firstname, 
lastname ,
score
from sales.customers 
where lastname like 'S%';

--17. Display orders shipped in the same month they were ordered 

select 
orderid, 
orderdate, 
shipdate, 
sales
from sales.orders 
where extract(month from orderdate)=extract(month from shipdate);

--18. Display customer whose country is neither USA nor Canada 

select 
customerid, 
firstname, 
country 
from sales.customers 
where country not in ('USA','Canada');

--19. Find products with prices ending in .99 

select 
product, 
price 
from sales.products 
where round(price % 1 ,2)=0.99;

--20. Display all orders created in December.

select 
orderid, 
orderdate, 
sales
from sales.orders 
where extract(month from orderdate)=12;



--Section B — Aggregation & Business KPIs (20)

--21. Find the average product price for each category 

select 
category, 
round(avg(coalesce(price,0)),2) as avg_price
from sales.products 
group by category;

--22. Display the total number of orders placed by each salesperson 

select 
o.salespersonid,
e.firstname,
count(o.orderid) as order_count
from sales.orders as o 
inner join sales.employees as e
on o.salespersonid=e.employeeid
group by o.salespersonid,
		e.firstname
order by o.salespersonid;

--23. Find the total sales amount for each order status .

select 
orderstatus,
sum(sales) as total_sales
from sales.orders 
group by orderstatus;

--24. Display the highest and lowest product price within each category .

select 
category, 
max(price) as highest_price,
min(price) as lowest_price
from sales.products 
group by category;


--25. Count employees in each department 

select 
department, 
count(employeeid) as employee_count
from sales.employees 
group by department;


--26. Find total revenue generated in each year

select 
extract(year from orderdate) as year_time, 
sum(sales) as total_sales
from sales.orders 
group by extract(year from orderdate);

--27. Display total revenue by each customer country.

select 
c.country, 
sum(o.sales) as total_sales
from sales.customers as c
inner join sales.orders as o 
on o.customerid=c.customerid
group by c.country;

--28. Find the average shipping time by order status

select 
orderstatus, 
round(avg(coalesce(shipdate-orderdate,0)),2) as avg_shipping_time
from sales.orders 
group by orderstatus;


--29. Count customers with missing scores by country 

select
country, 
count(customerid)
from sales.customers
where score is null
group by country,score ;

--30. Display categories having at least three products 

select 
category 
from sales.products 
group by category 
having count(productid)>=3;

--31. Find monthly order counts 

select 
to_char(orderdate,'YYYY-MM') as year_month ,
count(orderid) as order_count 
from sales.orders 
group by to_char(orderdate,'YYYY-MM')
order by year_month asc ;

--32. Display yearly average sales 

select
extract(year from orderdate) as year_time, 
round(avg(coalesce(sales,0)),2) as average_sales
from sales.orders 
group by extract(year from orderdate);

--33. Find departments whose average salary exceeds 60000 

select 
department, 
round(avg(coalesce(salary,0)),2) as avg_deparmental_salary
from sales.employees 
group by department; 

--34. Display total orders by shipping year. 

select 
extract(year from shipdate) as year_date, 
count(orderid) as order_count
from sales.orders 
group by extract(year from shipdate);


--35. Find the earliest order for each salesperson 

select 
o.salespersonid,
e.firstname,
min(orderdate) as earliest_date
from sales.orders as o 
inner join sales.employees as e
on o.salespersonid=e.employeeid
group by o.salespersonid,
		e.firstname
order by o.salespersonid;

--36. Find the latest shipment date by customer. 

select 
c.customerid, 
c.firstname, 
max(o.shipdate) as latest_shipment_date
from sales.orders as o 
inner join sales.customers as c
on c.customerid=o.customerid
group by c.customerid, 
		c.firstname
order by c.firstname asc;

--37. Display average customer score by country . 

select 
country, 
round(avg(coalesce(score,0)),2) as average_score 
from sales.customers 
group by country;

--38. Find total sales by weekdays 

select 
extract(dow from orderdate) as week_number, 
to_char(orderdate,'Day') as week_day,
sum(sales) as total_sales
from sales.orders 
group by to_char(orderdate,'Day') ,
		extract(dow from orderdate)
order by extract(dow from orderdate);


--39. Display average product price by first letter of category.

select 
category, 
round(avg(coalesce(price,0)),2) as average_price 
from sales.products 
group by category
order by category asc;


--40. Display total revenue generated each quarter.

select 
to_char(orderdate,'YYYY-Q') as Year_Quarter,
sum(sales) as total_revenue
from sales.orders 
group by to_char(orderdate,'YYYY-Q')
order by year_quarter asc;


-- Section C — CASE & Reporting (15)

-- 41. Classify products into budget, standard and premium based on price

select 
product, 
price, 
case
	when price > 5000 then 'Premium'
	when price > 2000 then 'Standard'
	else 'Budget'
end as product_category
from sales.products;

--42. Categorize employees into Young, Mid-Career, and Senior based on age.

select 
employeeid, 
firstname, 
extract(year from age(birthdate)) as age_employee,
case 
	when extract(year from age(birthdate)) >65 then 'Senior'
	when extract(year from age(birthdate)) >35 then 'Mid-Career'
	else 'Young'
end as age_category
from sales.employees;

--43. Display whether each order was shipped "On Time "(<= 7 dyas ) or "Delayed"

select 
orderid, 
orderdate, 
sales,
case 
	when shipdate is null then 'pending'
	when shipdate-orderdate >7 then 'Delayed'
	else 'On Time'
end as order_remarks
from sales.orders;

--44. Display whether customers have a score avaiable

select 
customerid,
firstname,
score , 
case 
	when score is null then 'Not avaialbe'
	else 'Availabe'
end as score_avaiability
from sales.customers;

--45. Categorize countries into Domestic vs International (define one country as domestic).

--Taking Nepal as Domestic 

select 
customerid,
firstname, 
country, 
case 
	when country ='Nepal' then 'Domestic'
	else 'International'
end as country_category 
from sales.customers;

--46. Display salary bands in intervals of your choice 

-- taking salary > 1 lakh as high , 40 k to 1 lakh as medium  ans less than 40 k as low

select 
employeeid, 
firstname, 
salary, 
case 
	when salary > 100000 then 'High'
	when salary > 40000 then 'Medium'
	else 'Low'
end as salary_category
from sales.employees;

--47. Classify sales as SMall, Medium and large 

select 
orderid, 
sales, 
case 
	when sales > 7000 then 'Large'
	when sales > 700 then 'Medium'
	else 'Low'
end as sales_category
from sales.orders;

--48. Display whether each product is Expensive or Affordabel using a chosen threshold 

--Taking threshold as 5k 

select 
product, 
price, 
case 
	when price > 5000 then 'Expensive'
	else 'Affordable'
end as remark
from sales.products;

/*
Display shipping speed categories:

Same Day
1–3 Days
4–7 Days
Over 7 Days
*/


select 
orderid,
orderdate, 
case 
	WHEN shipdate IS NULL THEN 'Pending'
	when shipdate-orderdate>7 then 'Over 7 days'
	when shipdate-orderdate >=4 then '4-7 days'
	when shipdate-orderdate >=1 then '1-3 days'
	else 'Same Day'
end as shipping_speed,
sales
from sales.orders;

--50. Display employees as Manager or Staff

select 
employeeid, 
department,
case
	when managerid is null then 'Manager'
	else 'Staff'
end as manager_staff,
salary
from sales.employees;

-- 51. Display customers as active or inactive based on whether they have orders. 

select distinct
c.customerid,
c.firstname,
case 
	when o.customerid is null then 'Inactive'
	else 'Active'
end as remark
from sales.customers as c 
left join sales.orders as o 
on c.customerid =o.customerid;


--52. Display products as Ordered or Never Ordered. 

select distinct
p.productid,
p.product,
case 
	when o.productid is not null then 'ordered'
	else 'Not ordered'
end as remarks 
from sales.products as p 
left join sales.orders as o 
on p.productid=o.productid; 

--53. Display whether each order has been shipped or is still pending 

select 
orderid, 
orderdate, 
shipdate, 
case 
	when shipdate is null then 'Still pending'
	else 'Shipped'
end as shipping_status 
from sales.orders; 

--54. Categorize orders months into Q1,Q2,Q3,Q4

select 
orderid, 
orderdate, 
to_char(orderdate,'Month') as order_month,
case 
	when extract(month from orderdate) in (1,2,3) then 'Q1'
	when extract(month from orderdate) in (4,5,6) then 'Q2'
	when extract(month from orderdate) in (7,8,9) then 'Q3'
	else 'Q4'
end as Order_quarter 
from sales.orders; 

--55. Display whether customer scores are above average, average or below average using fixed threesholds

-- Taking threeshold as 500

select 
customerid, 
firstname, 
score, 
case 
	when score > 500 then 'Above Average'
	when score =500 then 'Average'
	else 'Below Average'
end as remarks 
from sales.customers;

-- Section D — Multi-table JOIN Logic (10)

-- 56. Display customer name, product name and order date

select 
c.firstname as customer_name, 
p.product as product_name,
o.orderdate
from sales.orders as o 
inner join sales.customers as c
on c.customerid=o.customerid
inner join sales.products as p 
on p.productid=o.productid
order by c.firstname;


--57. Display employee name, customer name and sales amount 

select 
e.firstname as employee_name, 
c.firstname as customer_name, 
o.sales as sales_amount
from sales.orders as o 
inner join sales.customers as c
on c.customerid=o.customerid
inner join sales.employees as e
on e.employeeid=o.salespersonid
order by o.sales desc;

--58. Display customer country with total revenue. 

select 
c.country,
sum(o.sales) as total_revenue
from sales.customers as c
inner join sales.orders as o 
on o.customerid=c.customerid
group by c.country;

--59. Display product category with average sales.

select 
p.category, 
round(avg(coalesce(o.sales,0)),2) as average_sales
from sales.orders as o 
inner join sales.products as p 
on p.productid=o.productid 
group by p.category
order by average_sales desc;


--60. Display number of product sold in each category 


select 
p.category, 
count(o.orderid) as product_count
from sales.orders as o 
inner join sales.products as p 
on p.productid=o.productid 
group by p.category
order by product_count desc;

--61. Display each customer's latest order date

select 
	c.customerid, 
	c.firstname,
	max(o.orderdate) as latest_order
from sales.orders as o 
inner join sales.customers as c 
	on c.customerid=o.customerid
group by c.customerid,
		c.firstname
order by c.firstname;

--62. Display each salesperson's first sales date 

select 
e.employeeid,
e.firstname as salesperson,
min(o.orderdate) as first_order
from sales.orders as o 
inner join sales.employees as e
on e.employeeid=o.salespersonid
group by e.employeeid,
	e.firstname;

--63. Display each order with customer country 

select 
o.orderid,
o.orderdate,
o.sales,
c.country 
from sales.orders as o 
inner join sales.customers as c
on c.customerid=o.customerid
order by o.orderid asc;

--64. Display each order with employee department 

select 
o.orderid, 
o.orderdate,
o.sales,
e.department 
from sales.orders as o 
inner join sales.employees as e
on o.salespersonid=e.employeeid
order by o.orderid;

--65. Display total sales handled by each department 

select 
e.department ,
sum(o.sales) as total_sales
from sales.orders as o 
inner join sales.employees as e
on o.salespersonid=e.employeeid
group by e.department
order by total_sales desc;
