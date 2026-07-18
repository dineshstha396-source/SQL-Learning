-- SQL Date and Time Function 

-- 1. Find all orders with orderid, orderdate , order year , order month and order day 

select 
orderid, 
orderdate, 
extract(year from orderdate) as order_year,
extract(month from orderdate) as order_month,
extract(day from orderdate) as order_date
from sales.orders;

--2.  show the yearly order count

select 
extract(year from orderdate) as order_year,
count(orderid) as order_count
from sales.orders
group by extract(year from orderdate);

-- 3. show the monthly revenue 
select 
to_char(date_trunc('month',orderdate),'YYYY-MM') as month_name,
sum(sales) as totaL_sales
from sales.orders 
group by date_trunc('month',orderdate)

--4. Find the average number of days between shipdate and orderdate 

select 
round(avg(shipdate-orderdate)::numeric,2) as avg_del_time
from sales.orders;

--5. Find the Quartely sales

select 
extract(year from orderdate) as year_date,
extract(quarter from orderdate) as quarter,
sum(sales) as revenue 
from sales.orders 
group by extract(quarter from orderdate),
			extract(year from orderdate);