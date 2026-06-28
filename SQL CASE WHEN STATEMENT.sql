-- SQL CASE WHEN STATEMENT 

--CASE STATEMENT : Evaluates a list of conditions and returns a value when the first condition is met 


--Generate a report show the total sales for each category 
-- - High: IF the sales higher than 50 
-- - Medium: If the sales between 20 and 50 
-- - Low: If the sales equal or lower than 20 
-- ans sort the result from lowest to highest


select 
category,
sum(sales) as total_sales
from(
select 
orderid,
sales,
case
	when sales>50 then 'High'
	when sales>20 then 'Medium'
	else 'Low'
end as Category
from sales.orders
)t
Group by category
order by total_sales

-- Retrieve employee details with gender displayed as full text

-- Exploring data
select * from sales.employees;

-- Main logic
select 
employeeid,
firstname,
lastname,
gender,
case 
	when gender='F' then 'Female'
	when gender='M' then 'Male'
	else 'Not Avaiable'
end Gender_fulltext
from sales.employees;

-- Retrieve customer details with abbreviated country code

-- Knowing distinct country in the table 
select distinct country from sales.customers;

--Main Logic
select 
customerid,
firstname,
lastname
country,
Case 	
	When country='Germany' then 'DE'
	when country='USA' then 'US'
	else 'n/a'
end countryAbbr
from sales.customers;

-- Another way using quick format
select 
customerid,
firstname,
lastname
country,
Case country
	When 'Germany' then 'DE'
	when 'USA' then 'US'
	else 'n/a'
end countryAbbr
from sales.customers;


-- Find the average scores of customers and treat Nulls as 0 
-- Additionally provide details such as CustomerID and LastName

select 
customerid,
lastname,
score,
avg(
case
	when score is null then 0
	else score
end 
) over() avg_customers,
avg(score) over() avg_customer
from sales.customers


-- Count how many times each customer has made an order with sales greater than 30.

select 
customerid,
sum(case 
	when sales>30 then 1 
	else 0
end ) orders,
count(*) total_orders
from sales.orders
group by customerid
order by customerid

