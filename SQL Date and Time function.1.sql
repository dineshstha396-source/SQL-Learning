-- SQL Date and time functions 

-- Three sources of date data
select 
orderid,
orderdate,
shipdate,
creationtime, --1.Columns
'2025' as Year, --2. hardcoded
now() as Today --3. now()
from sales.orders;


-- Extract()

select 
orderid,
creationtime,
extract(year from creationtime) as year,
extract(month from creationtime) as month,
extract(day from creationtime) as day
from sales.orders;

--Date_Part(): for week , quarter

select
orderid,
date_part('week', creationtime) as week
from sales.orders;

select
orderid,
date_part('quarter', creationtime) as quarter
from sales.orders;

--To-char() - to convert date/time value into a formatted text representation

select 
orderid,
creationtime,
to_char(creationtime,'YYYY'),
to_char(creationtime,'YY'),
to_char(creationtime,'MM') ,
to_char(creationtime,'MON') , 
to_char(creationtime,'Mon')  ,
to_char(creationtime,'MONTH') ,
to_char(creationtime,'Month') ,
to_char(creationtime,'DD') ,
to_char(creationtime,'DY') ,
to_char(creationtime,'Dy') ,
to_char(creationtime,'DAY') ,
to_char(creationtime,'Day') ,
to_char(creationtime,'HH24') ,
to_char(creationtime,'HH12') ,
to_char(creationtime,'MI') ,
to_char(creationtime,'SS') 
from sales.orders;

--date_trunc() : Truncate the date to the specific part 

select 
orderid,
creationtime,
date_trunc('year',creationtime),
date_trunc('month',creationtime),
date_trunc('week',creationtime),
date_trunc('month',creationtime) + interval '1 month - 1 day' as End_of_month
from sales.orders;


--total order in each month

select 
date_trunc('month',creationtime),
count(*)
from sales.orders
group by date_trunc('month',creationtime);

--Use Cases

--Data Aggregation 

-- How many orders were placed each year? 

select 
extract(year from orderdate),
count(extract(year from orderdate))
from sales.orders
group by extract(year from orderdate);

-- How many orders were placed each year? 

select 
To_char(orderdate,'MONTH'),
count(To_char(orderdate,'MONTH'))
from sales.orders
group by To_char(orderdate,'MONTH');


-- Data filtering 

-- Show all orders that were placed during the month of January 

select 
*
from sales.orders
where To_char(orderdate,'Mon')='Jan';
