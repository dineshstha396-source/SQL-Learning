--SQL practice 

/* 1. 

Scenario

The sales manager wants a report showing customers from USA or Germany who have placed at least one order.

For each customer display:

Customer Full Name
Country (UPPERCASE)
Total Orders
Total Sales (rounded to 2 decimals)
Average Sales (rounded to 2 decimals)
First Order Date formatted as DD Mon YYYY

Filter only USA and Germany
Group correctly
Sort by
Total Sales (Descending)
Customer Name (Ascending)

*/

--Exploring data 

select * from sales.customers;
select * from sales.orders;

--Main logic 

select 
Concat(c.firstname,' ',c.lastname) as full_name,
upper(c.country) as Country,
count(o.orderid) as total_orders,
round(sum(o.sales),2) as Total_sales,
round((avg(o.sales)),2) as Avg_Sales,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
where c.country in('Germany','USA')
group by  c.customerid,
    c.firstname,
    c.lastname,
    c.country
order by total_sales desc , full_name asc;


/* 2. 


Scenario

The finance department wants to analyze product performance.

Using the salesdb database, create a report showing each product that has been ordered.

For each product, display:

Column	Requirement

product_name	Product name
category	    UPPERCASE
total_orders	Number of orders
total_quantity	Total quantity sold
total_sales	    Rounded to 2 decimals
average_sales	Rounded to 2 decimals
highest_sale	Highest sales value
first_order	    Earliest order date formatted as DD Mon YYYY

Show only products whose total sales exceed 1000
Sort by:
Total Sales (Descending)
Product Name (Ascending)

*/

-- Exploring data 

select * from sales.products;
select * from sales.orders;

--Main logic 

select 
p.product as product_name,
upper(p.category) as Category, 
count(o.orderid) as total_orders,
sum(o.quantity) as total_quantity,
round(sum(o.sales),2) as total_sales,
round(avg(o.sales),2) as average_sales,
max(o.sales) as highest_sale,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid
group by p.productid,p.product,p.category
having round(sum(o.sales),2) >1000
order by total_sales desc, product_name asc;


/* 3. 

Scenario

The sales team wants a customer performance report.

Create a report showing customers who have placed orders.

Display:

Customer full name
Country
Number of orders
Total quantity purchased
Total sales
Average order value
Latest order date

Business rules:

Only include customers from USA, Germany, and UK
Only include customers whose total sales are more than 500
Sort:
Highest total sales first
Customer name alphabetically

Use the sales.customers and sales.orders tables.
*/

--Exploring Data

select * from sales.customers;
select * from sales.orders; 

-- Main logic 

select 
concat(c.firstname,' ',c.lastname) as full_name,
Upper(c.country) as country,
count(o.orderid) as total_orders,
sum(o.quantity) as total_quantity,
round(sum(o.sales),2) as total_sales,
round(avg(o.sales),2) as average_sales,
to_char(max(o.orderdate),'DD Mon YYYY') as latest_order
from sales.orders as o
inner join sales.customers as c 
on c.customerid=o.customerid
where c.country in ('USA','Germany','UK')
group by c.customerid,c.firstname,c.lastname,c.country
having sum(o.sales) > 500
order by total_sales desc, full_name asc;


/* 4. 

Scenario

The operations team wants an order activity report.

Create a report showing each customer who has placed orders in 2021.

Display:

Column
Customer full name
Country
Total orders
Total sales
Average sales
First order date
Last order date
Number of days between first and last order

Business rules:

Only include orders from the year 2021
Only include customers whose total orders are 2 or more
Sort:
Total orders (highest first)
Total sales (highest first)
*/


select 
concat(c.firstname,' ',c.lastname) as full_name, 
c.country,
count(o.orderid) as total_orders,
round(sum(o.sales),2) as total_sales,
round(avg(o.sales),2) as average_sales,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order,
to_char(max(o.orderdate),'DD Mon YYYY') as last_order,
extract(day from age(max(o.orderdate),min(o.orderdate))) as day_diff
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid 
where extract(year from o.orderdate)=2021
group by c.customerid,c.firstname,c.lastname,c.country
having  count(o.orderid)>=2
order by total_orders desc, total_sales desc;

/* 5. 
The sales manager wants a monthly sales performance report.

Create a report showing sales performance for each month of 2021.

Display:

Column
Month name
Number of orders
Total quantity sold
Total sales
Average order sales
Highest single order sale

Business rules:

Only include orders from 2021
Month should appear like:

Example:

January
February
March
Sort months in chronological order (January → December)
Show only months where total sales are greater than 1000

*/

select 
To_char(orderdate,'FMMonth') as Month_name,
count(orderid) as Total_orders,
sum(quantity) as total_quantity,
sum(sales) as total_sales,
avg(sales) as average_sales,
max(sales) as highest_sales
from sales.orders 
where extract(year from orderdate)=2021
group by To_char(orderdate,'FMMonth')
having sum(sales) >1000
order by min(orderdate) asc;


/* 6. 

Scenario

The company wants a customer-product sales analysis report.

Create a report showing which customers bought which products.

Display:

Column
Customer full name
Product name
Category
Number of orders
Total quantity purchased
Total sales
First purchase date
Last purchase date

Business rules:

Only include purchases made in 2021
Only show customer-product combinations where total quantity is greater than 3
Sort:
Highest total sales first
Customer name ascending

*/




select 
concat(c.firstname,' ',c.lastname) as full_name, 
p.product as product_name,
p.category as category,
count(o.orderid) as total_orders,
sum(o.quantity) as total_quantity,
round(sum(o.sales),2) as total_sales,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order,
to_char(max(o.orderdate),'DD Mon YYYY') as last_order
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid 
inner join sales.products as p
on p.productid=o.productid
where extract(year from o.orderdate)=2021
group by c.customerid,c.firstname,c.lastname,c.country,p.product,p.category
having sum(o.quantity)>3
order by total_sales desc, full_name asc;


/* 7. 
Scenario

The marketing team wants a customer purchasing behavior report.

Create a report showing customers who purchased products.

Display:

Column
Customer full name
Country
Number of different products purchased
Total orders
Total quantity purchased
Total sales
First purchase date
Last purchase date
Days between first and last purchase

Business rules:

Only include customers from USA, Germany, and UK
Only include purchases made after 01 Jan 2021
Only show customers whose total sales are greater than 1000
Sort:
Total sales descending
Customer name ascending
*/


select 
concat(c.firstname,' ',c.lastname) as full_name, 
c.country,
count(distinct p.productid) as diff_product_purchased,
sum(o.quantity) as total_quantity,
count(o.orderid) as total_orders,
round(sum(o.sales),2) as total_sales,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order,
to_char(max(o.orderdate),'DD Mon YYYY') as last_order,
extract(day from age(max(o.orderdate),min(o.orderdate))) as day_diff
from sales.orders as o 
inner join sales.customers as c 
on c.customerid=o.customerid 
inner join sales.products as p
on p.productid=o.productid
where country in ('USA','Germany','UK') and  o.orderdate>'2021-01-01'
group by c.customerid,c.firstname,c.lastname,c.country
having sum(o.sales)>1000
order by total_sales desc, full_name asc;

/* 8.   

Scenario

The company wants a product performance report by category.

Create a report showing each product category's performance.

Display:

Column
Category
Number of different products
Total orders
Total quantity sold
Total sales
Average order sales
Highest single order sale
First sale date
Last sale date

Business rules:

Include only orders from 2021
Only include categories where:
Total sales > 2000
Total quantity sold > 10
Sort:
Total sales descending
Category ascending

*/

-- Exploring data 

select * from sales.products;
select * from sales.orders;

--Main logic 

select 
upper(p.category) as Category, 
count(distinct p.productid) as diff_product,
count(o.orderid) as total_orders,
sum(o.quantity) as total_quantity,
round(sum(o.sales),2) as total_sales,
round(avg(o.sales),2) as average_sales,
max(o.sales) as highest_sale,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order,
to_char(max(o.orderdate),'DD Mon YYYY') as last_order
from sales.products as p 
inner join sales.orders as o 
on p.productid=o.productid
where extract(year from o.orderdate)=2021
group by p.category
having sum(o.sales) >2000 and  sum(o.quantity)>10
order by total_sales desc, category asc;


