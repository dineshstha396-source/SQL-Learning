-- Null functions 

-- Find the average scores of the customers 
select 
customerid,
round(avg(score),2),
round(Avg(coalesce(score,0)),2)
from sales.customers
group by customerid;



-- Display the full name of customers in a single field by merging their first and last names, 
-- and add 10 bonus points to each customer's score.


select 
customerid,
firstname,
lastname,
firstname || ' '|| coalesce(lastname,' ') as full_name,
score,
coalesce(score,10) +10 as score1
from sales.customers;


-- sort the customers from  highest to lowest scores with NULLs appearing last

select 
customerid,
score
from sales.customers 
order by score desc NULLS last;

-- Find the sales price for each order by dividing sales by quantity 

select 
orderid,
sales,
quantity,
sales/nullif(quantity,0) as price
from sales.ordersarchive;

--Identify the customers who have no scores

select 
* 
from sales.customers
where score is null

--Identify the customers who have  scores

select 
* 
from sales.customers
where score is not null

-- List all details for customers who have not placed any orders 

select 
c.*,
o.orderid
from sales.customers as c 
left join sales.ordersarchive as o 
on c.customerid =o.customerid
where o.orderid is null

