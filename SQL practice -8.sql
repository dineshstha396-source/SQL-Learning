-- SQL Practice 

/* 1. 

Business requirement:

Create a customer list report.

Return:

Full customer name
Country in uppercase
Score (replace NULL score with 0)
Sort customers from highest score to lowest score, with NULL scores treated as 0

*/


select 
concat(firstname,' ',lastname) as full_name,
upper(country) as country,
coalesce(score,0) as score_clean
from sales.customers
order by score_clean desc;

/* 2. 
Create a sales summary for each customer.

Return:

customer full name
total number of orders
total sales amount
average sales amount
*/

select 
concat(c.firstname,' ',c.lastname) as full_name,
count(o.orderid) as total_orders,
round(sum(o.sales),2) as total_sales,
round(coalesce(avg(o.sales),0),2) as avg_sales
from sales.customers as c 
left join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.lastname;


/* 3. 

Create an order activity report.

Return:

customer full name
order year
number of orders
total sales

Requirements:

Show only orders from year 2021
Extract the year from orderdate
If total sales is NULL, show 0
Sort by total sales highest to lowest

*/

select 
concat(c.firstname,' ',c.lastname) as full_name,
extract(year from o.orderdate) as order_year,
count(o.orderid) as total_order,
round(coalesce(sum(o.sales),0),2) as total_sales
from sales.customers as c
inner join sales.orders as o
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.lastname,extract(year from o.orderdate)
having extract(year from o.orderdate)=2021
order by total_sales desc;