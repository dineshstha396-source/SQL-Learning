-- SQL Practice 

/* 1. 
The sales manager wants to identify customers who are becoming valuable.

For each customer, show:

customerid
Full name (firstname + space + lastname) as customer_name
Total number of orders
Total sales
Average sales per order (rounded to 2 decimals)
Customer category:
Premium → Total sales ≥ 1000
Standard → Total sales between 500 and 999.99
Basic → Below 500

Only include customers who have placed at least 2 orders.

Sort by:

Total sales (highest first)
Customer name (A–Z)
*/

select 
	c.customerid,
	concat(c.firstname,' ',c.lastname) as full_name,
	count(o.orderid) as total_orders,
	sum(o.sales) as total_sales,
	round(avg(o.sales),2) as avg_sales,
	case 
		when sum(o.sales) >= 1000 then 'Premium'
		when sum(o.sales) >=500 then 'Standard'
		else 'Basic'
	end as Customer_category
from sales.customers as c 
inner join sales.orders as o 
	on o.customerid=c.customerid
group by c.customerid,
		 c.firstname,
		 c.lastname
having count(o.orderid)>=2
order by 
		 total_sales desc,
		 full_name

/* 2. The sales manager wants to evaluate the performance of each salesperson.

For each salesperson, display:

salespersonid
Total number of orders handled
Number of completed orders
Total sales from completed orders only
Performance category:
Excellent → Completed sales ≥ 1500
Good → Completed sales between 800 and 1499.99
Needs Improvement → Below 800

Only include salespeople who have handled at least 3 orders in total (regardless of status).

Sort by:

Completed sales (highest first)
Salesperson ID (ascending)
*/

-- Exploring table data 

select * from sales.employees;
select * from sales.orders;

-- Main Logic
select 
	o.salespersonid,
	count(o.orderid) as total_orders,
	count(case when o.orderstatus='Shipped' then o.orderid else orderid end) as total_completed_order,
	sum(case when o.orderstatus='Shipped' then o.sales else 0 end) as total_sales_completed,
	case
		when sum(case when o.orderstatus='Shipped' then o.sales else 0 end) >= 1500 then 'Excellent'
		when sum(case when o.orderstatus='Shipped' then o.sales else 0 end) >=800 then 'Good'
		else 'Need Improvement'
	end as performance_category 
from sales.employees as s 
inner join sales.orders as o 
	on o.salespersonid=s.employeeid
group by o.salespersonid
having count(o.orderid)>=3
order by
		total_sales_completed desc, 
		o.salespersonid asc

/* 3. Business Scenario

The marketing team wants to understand customer purchasing behavior.

For each customer, display:

customerid
Customer full name
Total number of orders
Total sales
Number of high-value orders (orders with sales >= 300)
Total sales from high-value orders
Percentage of sales coming from high-value orders (rounded to 2 decimals)

Create a customer segment:

High Value → High-value sales contribute 70% or more of total sales
Medium Value → Between 40% and 69.99%
Low Value → Below 40%

Only include customers who:

Have placed at least 2 orders
Have total sales greater than 500

Sort by:

Percentage of high-value sales (highest first)
Total sales (highest first)
*/

select 
	c.customerid,
	concat(c.firstname,' ',c.lastname) as customer_full_name,
	count(o.orderid) as total_orders, 
	sum(o.sales) as total_sales, 
	COUNT(case when o.sales>=300 then o.orderid else null end) as high_value_order,
	sum(case when o.sales>=300 then o.sales else 0 end ) as high_total_sales,
	round(sum(case when o.sales>=300 then o.sales else 0 end )/sum(o.sales)*100.0,2) as percent_sales,
	case
		when sum( case when o.sales>=300 then o.sales else 0 end )/sum(o.sales)*100 >=70 then 'High Value'
		when sum( case when o.sales>=300 then o.sales else 0 end )/sum(o.sales)*100 >=40 then 'Medium Value'
		else 'Low Value'
	end as customer_segment
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,
		 c.firstname,
		 c.lastname
having count(o.orderid)>=2 
	and sum(o.sales)>500
order by 
		percent_sales desc,
		total_sales desc ; 


/*
4. The sales manager wants a monthly performance report.

Using sales.orders, generate a report showing each year-month:

Order year-month (YYYY-MM) as sales_month
Total number of orders
Total sales
Average order value (rounded to 2 decimals)
Number of high-value orders (sales >= 300)
Percentage of high-value orders (rounded to 2 decimals)

Create a monthly performance category:

Excellent → Total sales ≥ 2000
Good → Total sales between 1000 and 1999.99
Poor → Below 1000

Only include months where:

Total orders ≥ 3

Sort by:

Year-month ascending
Total sales descending
*/

select 
to_char(orderdate,'YYYY-MM') as sales_month, 
count(orderid) as total_orders, 
sum(sales) as total_sales, 
round(avg(sales),2) as avg_sales,
count(case when sales>=300 then orderid else null end) as high_value_order, 
round(sum(case when sales>=300 then sales else 0 end)/ sum(sales)*100.0,2) as percent_sales,
case 
	when sum(sales) >=2000 then 'Excellent'
	when sum(sales)>=1000 then 'Good'
	else 'Poor'
end as performance_category 
from sales.orders 
group by to_char(orderdate,'YYYY-MM')
having count(orderid)>=3
order by 
		sales_month,
		total_sales desc;

/* 5.  The product team wants to identify which products are driving revenue.

Using sales.products and sales.orders, create a product performance report.

For each product, display:

productid
Product name
Product category
Number of orders
Total quantity sold (Hint: your table may not have quantity, so ignore this metric)
Total sales
Average order sales (rounded to 2 decimals)
Highest single order value

Create a product classification:

Top Performer → total sales greater then 3000
Strong Performer → between 1500 and 300
Low Performer → Below 1500

Only include products with:

At least 2 orders
Total sales greater than 500

Sort by:

Percentage contribution (highest first)
Total sales (highest first)
*/

-- exploring data
select * from sales.orders;
select * from sales.products;

-- Main Logic
select 
p.productid, 
p.product,
p.category, 
count(o.orderid) as total_orders,
sum(o.quantity) as total_quantity,
sum(sales) as total_sales, 
avg(o.sales) as avg_sales,
max(o.sales) as max_sales,
case 
	when sum(o.sales) >= 3000 then 'Top Performer'
	when sum(o.sales) >=1500 then 'Strong Performer'
	else 'Low Performer'
end as product_classification 
from sales.orders as o 
inner join sales.products as p 
on p.productid=o.productid
group by p.productid, p.product,p.category
having count(o.orderid)>=2
	and sum(o.sales)>500
order by
		total_sales desc;

