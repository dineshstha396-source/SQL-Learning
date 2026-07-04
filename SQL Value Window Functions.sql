-- SQL VALUE WINDOW FUNCTIONS 

-- Analyze the month over month performace by finding the percentage change in sales 
-- between the current and previous months.

-- Exploring date 
select * from siales.orders;
i
-- Main logic

select 
*,
(current_month_sales-previous_month_sales) as MoM_Change,
round(cast((current_month_sales-previous_month_sales) as numeric)/previous_month_sales *100,1) as percent
from(
select 
extract(month from orderdate) order_month,
sum(sales) current_month_sales,
lag(sum(sales)) over(order by extract(month from orderdate))  as previous_month_sales
from sales.orders
group by extract(month from orderdate)
)t


-- Find the lowest and highest sales for each product 

select 
orderid,
productid,
sales,
first_value(sales) over(partition by productid order by sales asc) lowest_sales,
last_value(sales) over(partition by productid order by sales rows between current row and unbounded following) as highest_sales,
first_value(sales) over(partition by productid order by sales desc) highest_sale
from sales.orders;


-- Find the difference in sales between the current and the lowest sales

select 
orderid,
productid,
sales,
first_value(sales) over(partition by productid order by sales asc) lowest_sales,
sales - first_value(sales) over(partition by productid order by sales asc) Diff
from sales.orders;


