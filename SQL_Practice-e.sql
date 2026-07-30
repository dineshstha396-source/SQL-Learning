-- SQL Window Function Practice 

-- Section A — Ranking (10)

--1. Assign a unique ranking to employeed from the highest salary to the lowest.

select 
employeeid, 
firstname, 
salary,
row_number() over(order by salary desc) as unique_rank 
from sales.employees;

--2. Rank products by price within each category . 

select 
category, 
product,
price,
rank() over(partition by category order by price desc) as rank_product
from sales.products;

--3. Display customers with the same score receiving the same rank without gaps 

select 
customerid, 
firstname, 
coalesce(score,0), 
dense_rank() over(order by coalesce(score,0) desc) as rank_customer
from sales.customers;

--4. Number each customer's orders from oldest to newest. 

select 
c.customerid, 
c.firstname,
o.orderdate, 
row_number() over(partition by o.customerid order by o.orderdate asc) as order_number
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;

--5. Rank salespersons by total sales amount 

select 
o.salespersonid, 
e.firstname, 
sum(o.sales) as total_sales,
rank() over(order by sum(o.sales) ) as rank_salesperson
from sales.employees as e
inner join sales.orders as o 
on e.employeeid=o.salespersonid
group by o.salespersonid,e.firstname;

--6. Display products ordered from most expensive to least expensive inside every category 

select 
category, 
product, 
price, 
rank() over(partition by category order by price desc) as product_rank
from sales.products ; 

--7. Rank customers within each country by score 

select 
country, 
firstname,
coalesce(score,0), 
rank() over(partition by country order by coalesce(score,0) desc) as rank_customers 
from sales.customers;

--8. Assign row numbers to employees within each department ordered alphabetically.

select 
department ,
firstname,
row_number() over(partition by department order by firstname asc) as emp_no
from sales.employees;

--9. For each month, rank individual orders from highest sales to lowest sales.

select 
orderid,
rank() over(partition by to_char(orderdate,'YY-Month') order by sales desc) as month_rank,
to_char(orderdate,'YY-Month') as year_month,
sales
from sales.orders ;

--10. Display every product along with its rank within its category.

select 
category, 
product,
price,
rank() over(partition by category order by price desc) as product_rank
from sales.products;


-- Section B — Running Calculations (10)

--11. Display the srunning total sales for each customer based on order date. 

select 
o.customerid, 
c.firstname, 
o.orderdate, 
sum(o.sales) over(partition by o.customerid order by orderdate asc rows between unbounded preceding and current row) as running_sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;


--12. Display the running average sales for each customer. 


select 
o.customerid, 
c.firstname, 
o.orderdate, 
round(avg(coalesce(o.sales,0)) over(partition by o.customerid order by orderdate asc rows between unbounded preceding and current row),2) as running_avg_sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;

--13. Display the cumulative number of orders for every customer.

select 
o.customerid, 
c.firstname, 
o.orderdate, 
count(o.orderid) over(partition by o.customerid order by orderdate asc rows between unbounded preceding and current row) as cumulative_order_count
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid;

--14. Display the running revenue within each year

select 
orderdate,
sum(sales) over(partition by extract(year from orderdate) order by orderdate asc rows between unbounded preceding and current row  ) as cumulative_revenue
from sales.orders ;

--15. Display the running maximum sales for each customer.

select 
c.customerid, 
o.orderid,
o.orderdate, 
o.sales,
max(o.sales) over(partition by o.customerid order by orderdate asc rows between unbounded preceding and current row) as running_max_sales
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid;

--16. Display the running minimum sales for each customer.

select 
c.customerid, 
o.orderid,
o.orderdate, 
o.sales,
min(o.sales) over(partition by o.customerid order by orderdate asc rows between unbounded preceding and current row) as running_min_sales
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid;

--17. Display the running total salary within every department ordered by salary. 

select 
department, 
salary, 
sum(salary) over(partition by department order by salary asc) as running_salary
from sales.employees;

--18. Display the cumulative product count inside each category 

select 
category, 
product, 
count(productid) over(partition by category order by product asc) as running_product_count
from sales.products;

--19. Display the cumulative sales by salesperson 

select
e.employeeid,
e.firstname,
o.sales,
sum(o.sales) over(partition by o.salespersonid order by o.sales asc) as cumulative_sales
from sales.orders as o 
inner join sales.employees as e
on e.employeeid=o.salespersonid;

--20. Display cumulative monthly revenue 

select 
orderid,
orderdate,
sales,
sum(sales) over(partition by to_char(orderdate,'YY-Month') order by orderdate asc ) as cumulative_sales
from sales.orders;


--Section C — Previous & Next Values (10)

--21. Display every order together with the previous order's sales for the same customer.

select 
c.customerid, 
c.firstname,
o.sales,
lag(o.sales) over(partition by o.customerid order by o.orderdate asc ) as previous_sales
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid;

--22. Display every order together with the next order date for the same customer.

select 
c.customerid, 
c.firstname,
o.sales,
o.orderdate,
lead(o.orderdate) over(partition by o.customerid order by o.orderdate asc ) as next_orderdate
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid;

--23. Display the previous shipment date fro every order

select 
orderid, 
shipdate,
lag(shipdate) over(order by shipdate asc) as previous_shipment_date
from sales.orders;

--24. Display the difference in sales compared with the customer's previous order.

select 
orderid, 
customerid,
sales,
coalesce(sales - lag(sales) over(partition by customerid order by orderdate asc ),sales) as diff_sales
from sales.orders;

--25. Display the number of days between consecutive customer orders

select 
customerid, 
orderdate,
coalesce(orderdate - lag(orderdate) over( partition by customerid order by orderdate asc),0) as no_of_days_diff
from sales.orders;

--26. Display the difference between an employee's salary and the previous salary within the department.

select 
department,
employeeid, 
firstname,
salary,
coalesce(salary - lag(salary) over(partition by department order by salary asc),0) as salary_diff
from sales.employees;

--27. Display each product price together eith previous product price in the same category 

select 
category, 
product, 
price, 
lag(price) over(partition by category order by price asc) as previous_product_price
from sales.products;

--28. Display each customer's score together with the next customer's score 


select 
customerid, 
firstname , 
score , 
coalesce(lead(score) over(order by customerid ),0) as next_customer_score
from sales.customers;


--29. Display every order together with the previous order's sales within the same month.

select 
orderid, 
orderdate, 
sales,
lag(sales) over(partition by to_char(orderdate,'YY-MM') order by orderdate asc) as previous_sales
from sales.orders;

--30. Display each salesperson's current sale together with the next sale amount.

select 
salespersonid, 
sales,
lead(sales) over(partition by salespersonid order by orderdate asc) as next_salesman_sales
from sales.orders;


-- Section D — Value Functions (10)

--31. Display every customer's first orderdate 

select distinct
customerid, 
first_value(orderdate) over(partition by customerid order by orderdate asc) as first_orderdate
from sales.orders
order by customerid asc;

--32. Display every customer's latest order date.

select distinct
customerid, 
last_value(orderdate) over(partition by customerid order by orderdate asc rows between  unbounded preceding and unbounded following ) as latest_orderdate
from sales.orders
order by customerid asc;

--33. Display every customer's second order date.

select distinct
customerid, 
nth_value(orderdate,2) over(partition by customerid order by orderdate asc rows between  unbounded preceding and unbounded following  ) as second_orderdate
from sales.orders
order by customerid asc;


--34. Display every customer's first sales amount.

select distinct
customerid, 
first_value(sales) over(partition by customerid order by orderdate asc) as first_sales
from sales.orders
order by customerid asc;

--35. Display every customer's largest sales amount.


select distinct
customerid, 
orderid,
sales,
first_value(sales) over(partition by customerid order by sales desc rows between unbounded preceding and unbounded following) as largest_sales
from sales.orders
order by largest_sales desc;

--36. Display every department's highest salary beside every employee.

select 
department ,
employeeid, 
firstname, 
salary,
first_value(salary) over(partition by department order by salary desc rows between unbounded preceding and unbounded following) as highest_salary
from sales.employees;


--37. Display every department's lowest salary beside every employee.

select 
department ,
employeeid, 
firstname, 
salary,
last_value(salary) over(partition by department order by salary desc rows between unbounded preceding and unbounded following) as lowest_salary
from sales.employees;

--38. Display each product along with the price of the third highest-priced product in its category.

select 
category , 
product, 
price, 
nth_value(price,3) over(partition by category order by price desc rows between unbounded preceding and unbounded following) as third_highest_price
from sales.products;

--39. Display every customer's most recent sales amount.

select 
customerid, 
orderdate,
sales,
first_value(sales) over(partition by customerid order by orderdate desc ) as most_recent_sales
from sales.orders;

--40. Display the oldest employee in each department.

select 
department, 
employeeid, 
birthdate,
first_value(firstname) over(partition by department order by birthdate asc) as oldest_emp
from sales.employees;


--Section E — Distribution & Mixed Logic (10)

--41. Divide employees into 4 salary groups 

select 
employeeid, 
firstname, 
salary, 
ntile(4) over(order by salary desc) as employee_group
from sales.employees;

--42. Divide customers into 5 groups based on score.

select 
customerid, 
firstname ,
score, 
ntile(5) over(order by score desc) as customer_group 
from sales.customers;

--43. Calculate the relative ranking percentage of every customer's score.

select 
customerid, 
firstname, 
coalesce(score,0) , 
percent_rank() over(order by coalesce(score,0) desc) as percent_ranking 
from sales.customers ;


--44. Calculate the cumulative distribution of employee salaries.

select 
employeeid, 
firstname, 
salary, 
cume_dist() over(order by salary desc) as cumulative_distribution 
from sales.employees;

--45. Calculate the cumulative distribution of employee salaries.

select 
category , 
product, 
price, 
percent_rank() over(partition by category order by price desc) as percentage_ranking 
from sales.products;

-- 46. Display every employee together with the average salary of their department.

select 
department, 
employeeid, 
firstname, 
salary,
round(avg(coalesce(salary,0)) over(partition by department ),2) as average_salary
from sales.employees;

--47. Display every order together with the customer's total number of orders.

select 
orderid, 
customerid, 
count(orderid) over(partition by customerid ) as total_orders
from sales.orders;

--48. Display every product together with the average product price of its category.

select 
category , 
product, 
price, 
round(avg(coalesce(price,0)) over(partition by category)) as avg_price
from sales.products;

--49 . Display every customer together with the highest customer score in their country.

select 
country, 
customerid, 
firstname,
score, 
max(score) over(partition by country) as highest_score
from sales.customers;

/*
Create a report showing:

Customer Name
Order Date
Sales
Customer Running Sales
Previous Order Sales
Customer Order Number (1st, 2nd, 3rd, ...)
Customer's First Order Date

using a single SELECT statement with window functions.
*/


select 
o.customerid,
o.orderid,
concat(c.firstname,' ',c.lastname) as full_name,
o.orderdate,
o.sales,
sum(o.sales) over(partition by o.customerid order by orderdate asc) as cust_running_sales,
lag(o.sales) over(partition by o.customerid order by orderdate asc) as previous_sales,
row_number() over(partition by o.customerid order by orderdate asc) as order_number,
first_value(o.orderdate) over(partition by o.customerid order by orderdate asc) as first_order
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid;