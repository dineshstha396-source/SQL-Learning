-- SQl Practice 

/* 1. Show every order along with:

orderid
customerid
sales
the average sales of that customer
the difference between the order's sales and that customer's average sales
*/

select 
orderid,
customerid,
sales,
round(avg(sales) over(partition by customerid),2) as avg_sales,
round(sales-avg(sales) over(partition by customerid),2) as diff_sales
from sales.orders
order by orderid;

/* 2. For every order, display:

orderid
customerid
sales
the customer's sales rank (highest sales = rank 1)
the customer's previous order's sales (ordered by orderdate)
the difference between the current sale and the previous sale
*/

select 
orderid, 
customerid,
sales,
rank() over(partition by customerid order by sales desc ) as rank_customer,
lag(sales) over(partition by customerid order by orderdate asc) as previous_sales,
sales- lag(sales) over(partition by customerid order by orderdate asc) as diff
from sales.orders;

/* 3. For each order, show:

orderid
customerid
sales
orderdate
running total sales per customer (ordered by orderdate)
customer's average sales
difference between current sales and running total average up to that point
*/

select 
orderid,
customerid,
sales,
orderdate,
Sum(sales) over(partition by customerid order by orderdate asc rows between unbounded preceding and current row) as running_sales,
round(avg(sales) over(partition by customerid),2) as avg_sales,
round(sales-avg(sales) over(partition by customerid order by orderdate asc rows between unbounded preceding and current row),2) as diff
from sales.orders;

/* 4. For each order in sales.orders, return:

orderid
customerid
orderdate
sales

And compute:

Required computed columns
1.customer_total_sales
Total sales per customer
2.running_sales
Cumulative sales per customer ordered by orderdate

3.contribution_pct

Contribution of each order to customer total sales
sales/customer_total_sales
4.contribution_rank
Rank of each order within each customer based on contribution_pct
Highest contribution = rank 1
5.high_contribution_flag
'YES' if contribution_pct > 0.20
else 'NO'

*/

select 
*,
rank() over(partition by customerid order by contribution_pct desc) as contribution_rank,
case
	when contribution_pct >0.20 then 'Yes'
	else 'No' 
end as high_contribution_flag
from(
select 
orderid,
customerid,
orderdate ,
sales,
sum(sales) over(partition by customerid) as customer_total_sales,
sum(sales) over(partition by customerid order by orderdate asc rows between unbounded preceding and current row) as running_sales,
round((sales::numeric/sum(sales) over(partition by customerid )),2) as contribution_pct 
from sales.orders);
