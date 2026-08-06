-- SQL CTE 

--1. Find customers whose total sales are greater than 10,000 using CTE. 


with customer_sales
as (
select 
customerid, 
sum(sales) as total_sales
from sales.orders 
group by customerid
)
select 
*
from customer_sales 
where total_sales > 10000;

/*
2.The sales manager wants a report showing:

Customer ID
Customer name
Country
Total sales

Only include customers whose total sales are greater than 5000.
*/


with customer_sales as 
(
select 
customerid,
sum(sales) as total_sales
from sales.orders 
group by customerid
)
select
c.customerid, 
c.firstname,
c.country, 
t.total_sales
from sales.customers as c
inner join customer_sales as t
on t.customerid=c.customerid
where t.total_sales>5000;

/* 3. 
The company wants a report showing each employee's:

Employee ID
Employee name
Number of orders handled
Total sales generated
*/


with employees_sales as
(
select 
salespersonid, 
sum(sales) as total_Sales
from sales.orders 
group by salespersonid
)
,
employees_orders as
(
select 
salespersonid,
count(*) as number_of_orders
from sales.orders 
group by salespersonid
)
select 
e.employeeid, 
e.firstname, 
o.number_of_orders,
s.total_sales
from sales.employees as e
inner join employees_sales as s
on e.employeeid=s.salespersonid
inner join employees_orders as o
on e.employeeid=o.salespersonid;


/*
"4. Find each customer's sales contribution percentage compared to total company sales."

You will combine:

CTE
SUM()
Window function
*/

with customer_sales as
(
select 
customerid,
sum(sales) as total_sales
from sales.orders
group by customerid
)
select 
customerid, 
total_sales,
round(total_sales/sum(total_sales) over() *100,2) as sales_percentage
from customer_sales;

--4. Top 3 customers by total sales

with customer_sales as
(
select 
customerid,
sum(sales) as total_sales
from sales.orders
group by customerid
)
select 
customerid, 
total_sales,
rank() over(order by total_sales desc) as sales_rank
from customer_sales 
limit 3;



--Important CTE Business Series

--1. The sales manager wants to know the latest order placed by every customer.

with ranking as(
select 
customerid, 
orderid,
orderdate,
sales,
row_number() over(partition by customerid order by orderdate desc) as row_no
from sales.orders 
)
select 
customerid, 
orderid,
orderdate,
sales
from ranking 
where row_no =1;

--2. Top Customer in Each Country

with total_sales as (
select 
o.customerid,
sum(o.sales) as total_sales
from sales.orders as o 
group by o.customerid
)
,
ranking as 
(
select
c.country, 
c.firstname,
t.customerid,
t.total_sales,
row_number() over(partition by c.country order by t.total_sales desc) as row_no
from total_Sales as t 
inner join sales.customers as c
on c.customerid=t.customerid
)
select 
customerid,
firstname,
country,
total_sales
from ranking 
where row_no =1;


--3. The marketing team wants to identity customers based on how often they purchase 

with customer_purchase as(
select 
customerid, 
count(*) as purchase_count,
sum(sales) as total_sales
from sales.orders 
group by customerid
)
select 
c.customerid,
c.firstname,
c.country, 
p.total_sales,
p.purchase_count
from sales.customers as c
inner join customer_purchase as p
on p.customerid=c.customerid
where p.purchase_count>5
;

--4. Management wants to see monthly sales performance.

with monthly_sales as (
select  
extract(year from orderdate) as years,
extract(month from orderdate) as months,
sum(sales) as total_sales,
count(*) as orders,
round(avg(coalesce(sales,0)),2) as avg_order
from sales.orders 
group by extract(year from orderdate),
		extract(month from orderdate)
)
select 
*
from monthly_sales
order by years,months
;