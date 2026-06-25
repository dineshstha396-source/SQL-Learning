--SQL Practice 

/* 1. Using the sales.customers table, show: 

- customerid 
- full name as full_name
- country in uppercase as country_upper
- length of the first name as name_length 

sort the result by name_length in descending order. 
*/

--Exploring data 
select * from sales.customers; 

--Main Logic 
select 
customerid,
concat(firstname,' ',lastname) as full_name,
upper(country) as country_upper,
length(firstname) as name_length 
from sales.customers 
order by name_length desc;

/* 2. Using sales.products , Display: 
-productid
-product
-category
-price round to 0 decimal place as rounded_price
-first 4 characters of product name as short_name

Only show product where price is greater than 500 
sort by price from highest to lowest*/


-- Exploring Data 

select * from sales.products;

--Main logic 

select 
productid,
product,
category, 
round(price,0) as rounded_price,
left(product,4) as short_name
from sales.products
where price >500
order by rounded_price desc;

/* 3. Using sales.customers and sales.orders, show:

Customer full name as customer_name
Country in uppercase as country
Number of orders placed as total_orders
Total sales made by the customer as total_sales

Requirements:

Use CONCAT()
Use UPPER()
Use INNER JOIN
Sort by total_sales from highest to lowest
*/

--Exploring data 

Select * from sales.customers;
select * from sales.orders;

-- Main logic 

select 
concat(c.firstname,' ',c.lastname) as customer_name,
upper(c.country) as country,
count(o.orderid) as total_orders,
sum(o.sales) as total_sales
from sales.orders as o
inner join sales.customers as c 
on c.customerid=o.customerid 
group by c.customerid,c.firstname,c.lastname,c.country
order by total_sales desc;