--SQL practice 

/* 1. Write a query that return one row per customer with these columns 

| Column           | Requirement                                                                        |
| ---------------- | ---------------------------------------------------------------------------------- |
| customer_name    | Full name using CONCAT                                                             |
| first_order      | Earliest order date                                                                |
| last_order       | Latest order date                                                                  |
| customer_age     | Difference between CURRENT_DATE and first order using AGE()                        |
| total_orders     | Count of orders                                                                    |
| total_sales      | Sum of sales (replace NULL with 0)                                                 |
| avg_sales        | Average sales rounded to 2 decimals                                                |
| sales_level      | Using CASE WHEN:<br>• ≥1500 → 'High'<br>• 700–1499 → 'Medium'<br>• otherwise 'Low' |
| first_order_year | Extract the year from first order                                                  |
| order_status     | CASE WHEN:<br>• no orders → 'Never Ordered'<br>• otherwise → 'Existing Customer'   |

*/



--Exploring data 

select * from sales.customers;
select * from sales.orders;

-- Main logic 

select 
concat(c.firstname,' ',c.lastname) as customer_name,
to_char(min(o.orderdate),'DD Mon YYYY') as first_order,
to_char(max(o.orderdate),'DD Mon YYYY') as last_order,
AGE(current_date,min(o.orderdate)) as customer_age,
count(o.orderid) as total_orders,
round(coalesce(sum(o.sales),0),2) as total_sales,
round(coalesce(avg(o.sales),0),2) as avg_sales,
case 
	when coalesce(sum(o.sales),0)>=1500 then 'High'
	when coalesce(sum(o.sales),0)>=700 then 'Medium'
	else 'Low'
end as Sales_level,
extract(year from min(o.orderdate)) as first_order_year,
case
	when count(o.orderid)=0 then'Never Ordered'
	else 'Existing Customer'
end as order_status 
from sales.customers as c
left join  sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.lastname;


/* 2. 

Using salesdb, create a customer performance report

Return : 
| Column             | Requirement                                                                                                                                                                      |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| customer_name      | Full customer name                                                                                                                                                               |
| first_purchase     | Date of first order                                                                                                                                                              |
| months_as_customer | Number of months since first purchase until today                                                                                                                                |
| purchase_year      | Year of first purchase                                                                                                                                                           |
| total_orders       | Number of orders                                                                                                                                                                 |
| total_quantity     | Total quantity purchased                                                                                                                                                         |
| total_sales        | Total sales amount                                                                                                                                                               |
| avg_order_value    | Average sales per order                                                                                                                                                          |
| customer_segment   | Classify customers: <br><br>• Sales >= 2000 → 'Premium'<br>• Sales between 500 and 1999 → 'Regular'<br>• Sales below 500 → 'Low Value'<br>• No purchase → 'No Customer Activity' |
| purchase_frequency | Classify: <br><br>• More than 5 orders → 'Frequent'<br>• 2–5 orders → 'Occasional'<br>• 1 order → 'One Time'<br>• No orders → 'None'                                             |
| sales_status       | If total sales is missing, show 'No Sales'; otherwise 'Active'                                                                                                                   |

conditions: 
1. Include customers even if they never ordered.
2. Round monetary values to 2 decimals
3. Sort customers from highest total sales to lowest
4. Do not use CTE or subquery.
*/

select 
concat(c.firstname,' ',c.lastname) as customer_name,
to_char(min(o.orderdate),'DD Mon YYYY') as first_purchase, 
extract(year from age(current_date,min(o.orderdate)))*12 + extract(month from age(current_date,min(o.orderdate))) as months_as_customer,
extract(year from min(o.orderdate)) as purchase_year,
count(o.orderid) as total_orders,
sum(o.quantity) as total_quantity,
round(coalesce(sum(o.sales),0),2) as total_sales,
round((coalesce(sum(o.sales),0))/(nullif(count(o.orderid),0)),2) as avg_order_value,
round(avg(o.sales),2) as avg_order_value,
case 
	when count(o.orderid)=0 then 'No customer Activity'
	when sum(o.sales)>=2000 then 'Premium'
	when sum(o.sales)>=500 then 'Regular'
	else 'Low Value'
end as Customer_segment,
case 
	when count(o.orderid) > 5 then 'Frequent'
	when count(o.orderid) >=2 then 'Occasional'
	when count(o.orderid) =1 then 'One time'
	else 'None'
end as purchase_frequency,
case 
	when sum(o.sales) is null then 'No Sales'
	else 'active'
end as sales_status 
from sales.customers as c
left join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid,c.firstname,c.lastname
order by total_sales desc;
	
