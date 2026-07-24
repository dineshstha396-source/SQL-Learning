-- SQL practice 

--Date & Time Functions (12 Questions)

-- 1. Display each order along with the year, quarter,month and day extracted fro the order date

select 
orderid, 
orderdate, 
extract(year from orderdate) as year_time,
extract(quarter from orderdate) as quarter_time,
extract(month from orderdate) as month_time,
extract(day from orderdate) as Day_time,
sales
from sales.orders ;

--2. Display each order and show the full month name. 

select 
orderid, 
orderdate, 
to_char(orderdate,'Month') as month_time,
sales
from sales.orders;

--3. Find total sales for each year. 

select 
extract(year from orderdate) as year_time, 
sum(sales) 
from sales.orders 
group by extract(year from orderdate);

--4. Find total sales for each quarter. 

select 
to_char(orderdate,'YYYY-Q') as year_time, 
sum(sales) as total_sales
from sales.orders 
group by to_char(orderdate,'YYYY-Q');

--5. Find total sales for each month. 

select 
to_char(orderdate,'YYYY-MM') as year_time, 
sum(sales)  as total_sales
from sales.orders 
group by to_char(orderdate,'YYYY-MM');

/*
Calculate the number of days taken to ship each order.

Display:

orderid
orderdate
shipdate
shipping_days
*/


select 
orderid, 
orderdate, 
shipdate, 
shipdate-orderdate as shipping_days 
from sales.orders ; 

--7. FInd all orders tha took more than 10 days to ship 


select 
orderid, 
orderdate, 
shipdate, 
shipdate-orderdate as shipping_days 
from sales.orders 
where shipdate-orderdate >10; 


--8. Display the weekday on which each order was placed

select 
orderid, 
sales,
trim(to_char(orderdate,'Day')) as day_time
from sales.orders;

--9. Find the numbers of orders placed on each weekday 

select 
extract(dow from orderdate) as week_number,
trim(to_char(orderdate,'Day')) as day_time,
count(orderid) as order_Count
from sales.orders 
group by extract(dow from orderdate) ,
		trim(to_char(orderdate,'Day'))
order by week_number;	

--10. Find the earliest and latest order date for each customer 

select 
customerid,
min(orderdate) as earliest_order,
max(orderdate) as latest_order
from sales.orders 
group by customerid;

--11. Display each employee's age in years;

select 
employeeid,
firstname,
extract(year from age(birthdate)) as years
from sales.employees;

--12. Find employees born in the 1990s .

select 
employeeid, 
firstname,
birthdate
from sales.employees
where birthdate between '1990-01-01' and '1999-12-31' ;


-- NULL Handling (8 Questions)

-- 13. Replace null customer scores with 0 

select 
customerid, 
firstname ,
coalesce(score,0) as score
from sales.customers; 

--14. Replace null customers countries with 'Unknown'

select 
customerid, 
firstname, 
coalesce(country,'Unknown') as country 
from sales.customers; 

-- 15. Display customers whose score is missing.

select 
customerid, 
firstname, 
score
from sales.customers 
where score is null; 

--16. Display customers chose country is avaiable

select 
customerid, 
firstname, 
country 
from sales.customers 
where country is not null;

/*
Display each customer and indicate whether their score is "Available" or "Missing".

Expected output:

customerid
firstname
score_status
*/

select 
customerid, 
firstname,
case 
	when score is null then 'Missing'
	else 'Avaiable'
end as score_status
from sales.customers;

/*
18.Display each order and replace a NULL shipdate with the text "Not Shipped Yet".

Expected output:

orderid
orderdate
shipdate
*/

select 
orderid, 
orderdate, 
coalesce(to_char(shipdate,'YYYY-MM-DD'),'Not shipped Yet') as ship_status
from sales.orders ;


/*
19. Calculate the shipping duration (in days) for each order. If the shipdate is NULL, display 0 as the shipping duration.

Expected output:

orderid
orderdate
shipdate
shipping_days
*/

select 
orderid, 
orderdate, 
shipdate, 
coalesce(shipdate-orderdate,0) as shipping_days
from sales.orders;


-- 20. Display customers ordered by score from highest to lowest, placing customers with NULL scores at the end.


select 
customerid, 
firstname,
score 
from sales.customers 
order by score desc nulls last;
