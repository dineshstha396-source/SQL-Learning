--SQL practice 

/* 1. Using the sales.orders table, display: 
- orderid
- customerid
- creationtime 
- month name 
- year
- quarter 
- month- year in the format : jan-2021
*/

select 
orderid,
customerid, 
creationtime, 
to_char(creationtime,'FMMonth') as month_name,
extract(year from creationtime) as year, 
date_part('quarter',creationtime) as quarter, 
to_char(creationtime,'Mon-YYYY') as month_year
from sales.orders
order by creationtime asc;


/* 2. Using the sales.orders table , write a query that displays: 
- orderid
- creationtime 
- day_name
- day_of_year
- week_no 
- month_start
- formatted_date
sort the creationtime ascending */

select
orderid,
creationtime, 
to_char(creationtime,'FMDay') as day_name,
extract(DOY from creationtime) as day_of_year,
date_part('week',creationtime) as week_no,
date_trunc('month',creationtime) as month_start,
to_char(creationtime,'DD-Mon-YYYY') as formatted_date 
from sales.orders
order by creationtime asc;