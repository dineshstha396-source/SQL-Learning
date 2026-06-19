-- SQL practice 

/*1. Using the sales.customers table: show the first name , country and score 
of customers whose score is greater than 500 */

select 
firstname,
country,
score
from sales.customers
where score >500;

/* 2. Using customers table , show the first name , score and country of 
customers who are from usa and have a score greater than 500 */

select 
firstname, 
country,
score 
from sales.customers 
where score >500 and country='USA';

/* 3. Using customers table , show the first name , score and country of 
customers who are from usa or germany and have a score between 300 and 800 and sort 
the result by score descending*/

select 
firstname, 
country,
score 
from sales.customers 
where score between 300 and 500 and country in ('USA','Germany')
order by score desc;


/* 4. Using order table , show orderid, order date and sales
where sales is greater then 50 and sales is not equal to 100
ans sort by sales from highest to lowest */

select 
	orderid,
	orderdate,
	sales
from sales.orders 
where sales>50 and sales!=100 
order by sales desc;


/* 5. Using sales.customers 
find the number of customers in each country 

output should show 
country and total number of customers */

select 
country,
count(country) as TOTAL_CUSTOMERS
from sales.customers 
group by country;

/* 6. Using sales.customers 
find countries that haves more than 1 customers 

output: 
country 
number of customers 

*/

select 
country,
count(country) as TOTAL_CUSTOMERS
from sales.customers 
group by country
having count(country)>1;


/* 7. using sales.customers 
find the average score of customers in each country */

select 
country,
round(avg(SCORE),2) as AVG_SCORE
from sales.customers 
group by country;

/* 8. Using sales.customers 
Find the countries where the average customer score is greater than 400 
ans sort by average score descending*/

select 
country,
round(avg(SCORE),2) as AVG_SCORE
from sales.customers 
group by country
having avg(score) >400 
order by avg(score) desc;

/* 9. Using sales.orders 
Find the total sales amount for each customer

show 
customerid and total sales
only show customers whose total sales are greater than 50 
and sort by total sales descending */

select 
customerid, 
sum(sales) as total_sales
from sales.orders
group by customerid
having sum(sales)>50
order by sum(sales) desc;

/* 10.Using sales.orders:

Find the total sales amount for each order status.

Show:

orderstatus
total sales

Only show order statuses where total sales is greater than 100.

Sort by total sales descending. */

select 
orderstatus,
sum(sales) as total_sales
from sales.orders 
group by orderstatus
having sum(sales)>100
order by sum(sales) desc;

