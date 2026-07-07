-- SQL CTE 

--step 1: Find the total sales per customer
-- CTE Queries
with cte_total_sales as
(
select 
	customerid,
	sum(sales) as total_sales
from sales.orders 
group by customerid
)
-- Step2: Find the last order date for each customer
, CTE_Last_order as 
(
select 
	customerid,
	max(orderdate) as last_order
from sales.orders
group by customerid
),
--Step 3 : Rank customers based on total sales per customer
cte_Rank as
(
select 
	customerid,
	total_sales,
	rank() over(order by total_sales desc) as customer_rank
from cte_totaL_sales
),
cte_segment as
(
select 
	customerid,
	case
		when total_sales>125 then 'High'
		else 'Low'
	end as segmentation
from cte_total_sales
)
-- Main Query 
select 
	c.customerid,
	c.firstname,
	c.lastname,
	cts.total_sales,
	clo.last_order,
	crk.customer_rank,
	csk.segmentation
from sales.customers as c
left join cte_total_sales as cts
on cts.customerid=c.customerid
left join cte_last_order as clo
on clo.customerid=c.customerid
left join cte_rank as crk
on crk.customerid=c.customerid
left join cte_segment as csk
on csk.customerid=c.customerid;