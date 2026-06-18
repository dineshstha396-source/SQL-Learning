-- I am just trying to learn SQL(PostgreSQL) to talk to Data 



-- Select practice 

-- 1.Display all columns for customers whose country is USA

select * from sales.customers where country='USA';

--2. Using customers tabel , display the first name, country , and score of customers whose score is greater than 500 

select 
	firstname,
	country,
	score
from sales.customers
where score >500;

--3. Using Product table , display the product name and price of products where the price is between 50 and 200

select 
	product, 
	price 
from sales.products
where price between 50 and 200;


--4. Display the first name, country and score of all customerss and sort the result from highest to lowest using customers table 

select 
	firstname,
	country,
	score
from sales.customers
order by score desc;

/*
5. Using the order table, display orderid,orderdate,sales for orders
where the sales amount is greater than 50 and 
then sort the result by sales from highest to lowest.
*/

select 
	orderid,
	orderdate,
	sales
from sales.orders
where sales>50
order by sales desc;