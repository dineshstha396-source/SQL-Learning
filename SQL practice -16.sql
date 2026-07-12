-- SQL practice 

/* 1. Find the average price of products per category, and show only categories where the average price is greater than 500.

Output:
category
average_price
*/

select 
*
from 
(
select category,avg(price) as avg_price from sales.products group by category
)t 
where avg_price>500

/* 2. Find categories where total price sum is greater than 1000.

Output:
category
total_value

*/

select 
	category,
	total_value 
from 
( select 
	category, 
	sum(price) as total_value
  from sales.products
  group by category
  )t 
where total_value>1000;


/* 3. Find products whose price is greater than the average price of their category.

Output:
productid
product
price
category
*/



select 
productid,
product,
price,
category
from sales.products as p1
where price> (select avg(price) from sales.products as p2 where p1.category= p2.category);
