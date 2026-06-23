-- SQL Practice 

/* 1. Using the salesdb database: 
Write a query to display : 
-first name 
-Total number of orders placed by each cutomers 

requirements: 
- Use customers and orders tables 
- Show customers who have placed at least one order. 
- Sort the result by number of orders in descending order. 
*/


-- checking the table structure and data

select * from sales.customers;
select * from sales.orders;

select 
c.firstname,
count(o.orderid) as total_orders
from sales.customers as c 
left join sales.orders as o -- to join twp table
on c.customerid=o.customerid
where o.orderid is not null -- for at least one orders
group by c.customerid,c.firstname -- to find total orders per customers
order by count(o.orderid) desc; -- to sort the result


/* 2. Using sales.customers and sales.orders: 

Display 
- first name 
- country 
- total sales made by each customer 

requirements : 
- include only customers whose total sales are greater than 1000.
- sort the total sales from highest to lowest 
*/

-- checking the table structure and data

select * from sales.customers;
select * from sales.orders;

select 
c.firstname,
c.country,
sum(o.sales) as total_sales
from sales.customers as c
left join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.country
having sum(o.sales)>1000
order by sum(o.sales) desc;


/* 3. Using sales.customers and sales.orders: 

Find customers who have never placed and order. 
Return:

| customerid | firstname | lastname |

Requirements:

Use a JOIN-based solution.
Do not use NOT IN.
*/

-- checking the table structure and data

select * from sales.customers;
select * from sales.orders;

-- SQL logic 
select 
c.customerid,
c.firstname,
c.lastname
from sales.customers as c 
left join sales.orders as o 
on c.customerid=o.customerid
where o.customerid is null;


/* 4. Using sales.orders: 

Find the top 3 customers by total sales

Return:

customerid	total_sales

Requirements:

Use aggregation.
Sort highest sales first.
Show only top 3 customers.
*/

select 
customerid, 
sum(sales) as total_sales
from sales.orders 
group by customerid
order by sum(sales) desc 
limit 3;


/* 5. Find customers whose total sales are greater than 500.

Return:

customerid	firstname	total_sales

Requirements:

Use customers and orders tables.
Show customer name.
Calculate total sales per customer.
Filter after aggregation (use the correct clause).
Sort highest total sales first.
*/


-- checking the table structure and data

select * from sales.customers;
select * from sales.orders;

-- Main Logic 

select 
c.customerid ,
c.firstname,
sum(o.sales) as total_sales 
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname
having sum(o.sales)>500
order by sum(o.sales) desc;


/* 6. Find the total sales for each product.

Tables:

sales.products
sales.orders

Return:

product	total_sales

Requirements:

Join products with orders.
Calculate total sales per product.
Sort highest total sales first.
*/


-- checking the table structure and data

select * from sales.products;
select * from sales.orders;

-- Main logic 

select 
p.product,
sum(o.sales) as total_sales
from sales.orders as o 
inner join sales.products as p 
on p.productid=o.productid
group by p.productid,p.product 
order by total_sales desc;


/* 7.Find the number of orders for each product category.

Tables:

sales.products
sales.orders

Return:

category	number_of_orders

Requirements:

Join the tables.
Count orders.
Show categories with highest order count first
*/

-- checking the table structure and data

select * from sales.products;
select * from sales.orders;

-- Main logic 

select 
p.category,
count(o.orderid) as number_of_orders
from sales.orders as o 
inner join sales.products as p 
on p.productid=o.productid
group by p.category 
order by number_of_orders desc;


/* 8. Find customers who have placed more than 2 orders.

Tables:

sales.customers
sales.orders

Return:

firstname	number_of_orders

Requirements:

Use JOIN.
Count orders per customer.
Filter customers after counting.
*/


-- checking the table structure and data

select * from sales.customers;
select * from sales.orders;

-- Main Logic 

select 
c.firstname,
count(o.orderid) as number_of_orders
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname
having count(o.orderid) >2;

/* 9.Find products that have never been ordered.

Tables:

sales.products
sales.orders

Return:

productid	product

Requirements:

Use JOIN.
Use the anti-join logic you learned.
Do not use NOT IN.
*/

-- checking the table structure and data

select * from sales.products;
select * from sales.orders;

-- Main logic 

select 
p.product,
p.productid
from sales.products as p
left join sales.orders as o  
on p.productid=o.productid
where o.orderid is null;

/* 10.Find the total sales made by each country.

Tables:

sales.customers
sales.orders

Return:

country	total_sales

Requirements:

Join customers and orders.
Calculate total sales per country.
Show countries with highest sales first.
*/

-- checking the table structure and data

select * from sales.customers;
select * from sales.orders;

-- Main Logic 

select 
c.country,
sum(o.sales) as total_sales 
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.country
order by total_sales desc;


