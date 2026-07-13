-- SQL PRACTICE 

/*1. The sales director wants to reward the company's best customers.

However, they don't want a list of all customers. They only want customers whose total sales are above the company average customer sales.

Step 1

Calculate, for each customer:

customerid
Customer full name
Total orders
Total sales
Step 2

From those customer totals:

Return only customers whose:

customer total sales > average customer total sales

Display:

customerid
customer_name
total_orders
total_sales

Sort by:

Total sales DESC
Customer name ASC */ 


with cte_total_sales as 
(
select 
c.customerid,
concat(c.firstname,' ',c.lastname) as customer_fullname, 
count(o.orderid) as total_orders, 
sum(o.sales) as total_sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid
)
select 
cts.customerid, 
cts.customer_fullname,
cts.total_orders,
cts.total_sales
from cte_total_sales as cts
where cts.total_sales> ( select avg(total_sales)  from cte_total_sales  )
order by total_sales ,
		customer_fullname;

/* 2.The sales director wants to identify the best customer from each country.

Step 1

For every customer, calculate:

customerid
Customer full name
Country
Total orders
Total sales
Step 2

Within each country, rank customers based on:

Highest total sales
If tied, more total orders
If still tied, customer name alphabetically
Step 3

Return only the top-ranked customer from each country.

Display:

customerid
customer_fullname
country
total_orders
total_sales

Sort by:

Country (A–Z)
Total sales (highest first)
*/


with cte_customer as 
(
select 
c.customerid,
concat(c.firstname,' ',c.lastname) as full_name,
c.country, 
count(o.orderid) as total_orders, 
sum(o.sales) as total_sales
from sales.customers as c 
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.lastname,c.country
),
cte_country as 
(
select
c.customerid,
row_number() over(partition by cc.country order by cc.total_sales desc, cc.total_orders desc, cc.full_name asc) as rank_customers
from cte_customer as cc
inner join sales.customers as c 
on c.customerid=cc.customerid
)
select 
cc.customerid,
cc.full_name,
cc.country,
cc.total_orders,
cc.total_sales
from cte_customer as cc
inner join cte_country as ccc 
on ccc.customerid=cc.customerid
where ccc.rank_customers=1
order by cc.country asc,
		cc.total_sales desc ;

select now()
