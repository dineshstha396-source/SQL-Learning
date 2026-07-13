--- SQL practice 

/* 1. Create a CTE named customer_sales that calculates the total sales for each customer.

Then display:

customerid
firstname
lastname
total_sales
Requirements:

Use a CTE.
Include customers who have no orders (their total should be 0).
Sort by total_sales in descending order.
*/


with cte_total_sales as (
	select 
		customerid,
		sum(sales) as total_sales
	from sales.orders
	group by customerid
)
select 
	c.customerid,
	c.firstname,
	c.lastname,
coalesce(cts.total_sales,0) as total_sales
from sales.customers as c
left join cte_total_sales as cts
	on cts.customerid=c.customerid
order by coalesce(total_sales,0) desc;


/* 2. Create two CTEs.

1.customer_sales
customerid
total_sales
2.customer_avg
Calculate the average of all customers' total_sales from the first CTE.

Finally, display:

customerid
firstname
lastname
total_sales
above_average ('Yes' if the customer's total sales are greater than the average, otherwise 'No')

Requirements:

Use exactly two CTEs.
Use the second CTE to compute the average.
Include only customers who have at least one order.

*/

with cte_total_sales as (
	select 
		customerid,
		sum(sales) as total_sales 
	from sales.orders 
	group by customerid
),
cte_avg_sales as(
	select 
	customerid,
	avg(total_sales) over() as avg_sales
	from cte_total_sales
)
select 
customerid,
firstname,
lastname,
total_sales,
case 
when total_sales> avg_sales then 'Yes'
else 'No'
end as above_average
from(
select 
c.customerid,
c.firstname,
c.lastname,
cts.total_sales,
cas.avg_sales
from sales.customers  as c
inner join cte_total_sales as cts
on cts.customerid=c.customerid
inner join cte_avg_sales as cas
on cas.customerid=c.customerid
)t


/* 3. Using the sales.orders table, create three CTEs.

CTE 1: customer_sales

For each customer, calculate:

customerid
total_sales
total_orders
CTE 2: customer_stats

Using the first CTE, calculate:

avg_total_sales
avg_total_orders

These should each be one value (overall averages).

CTE 3: customer_classification

Using the first two CTEs, classify each customer:

High Value → total_sales > avg_total_sales AND total_orders > avg_total_orders
Otherwise → Regular
Final Output

Display:

customerid	firstname	lastname	total_sales	total_orders	customer_type

Requirements:

Use exactly 3 CTEs.
Use a CROSS JOIN (or another valid method) to bring the overall averages into the classification step.
Include only customers with orders.
Sort by total_sales descending.
*/

with cte_customer_sales as (
	select 
		customerid,
		sum(sales) as total_sales,
		count(orderid) as total_orders 
	from sales.orders 
	group by customerid
),
cte_customer_stats as(
	select 
		ccs.customerid,
		avg(ccs.total_sales) over() as avg_total_sales,
		avg(ccs.total_orders) over() as avg_total_orders
	from cte_customer_sales  as ccs
),
cte_customer_classification as 
(
	select 
		ccs.customerid,
		case 
			when ccs.total_sales > cccs.avg_total_sales and ccs.total_orders > cccs.avg_total_orders then 'High Value'
			else 'Regular'
		end as customer_classification
	from cte_customer_sales as ccs
	inner join cte_customer_stats as cccs 
	on ccs.customerid=cccs.customerid
)
select 
	c.customerid,
	c.firstname,
	c.lastname,
	ccs.total_sales,
	ccs.total_orders,
	ccc.customer_classification as customer_type
from sales.customers as c
inner join cte_customer_sales as ccs
	on ccs.customerid=c.customerid
inner join cte_customer_classification as ccc
	on ccc.customerid=c.customerid;


