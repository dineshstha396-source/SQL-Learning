-- Rank the orders based on their sales from highest to lowest 

select 
	orderid,
	productid,
	sales,
	row_number() over(order by sales desc) row_number1,
	rank() over(order by sales desc) rank1,
	dense_rank() over(order by sales desc) dense_rank2
from sales.orders;


-- Find the top highest sales for each products 

select * 
from(
select 
	orderid,
	productid,
	sales,
	row_number() over(partition by productid order by sales desc) as rank_by_product
from sales.orders)t where rank_by_product=1

--Find the lowest 2 customers based on their sales

select * from (
select 
	customerid,
	sum(sales) as total_sales,
	row_number() over(order by sum(sales)) rank_customer
from sales.orders
group by customerid
)t where rank_customer<=2;

-- Assign unique IDs to rows of the 'orders Archive' table 

select 
row_number() over(order by orderid,orderdate) as unique_id,
*
from sales.ordersarchive;


-- Identify duplicate rows in the table 'Order Archive' 
-- and return a clean result without any duplicates 

select * from(
select 
row_number() over(partition by orderid order by creationtime desc) rn,
*
from sales.ordersarchive
)t where rn=1;


-- Segmetn all orders into 3 categories : High , medium and low sales. 

select 
*,
case 
	when buckets=1 then 'High'
	when buckets=2 then 'Medium'
	when buckets=3 then 'Low'
end sales_segmentation
from(
select 
orderid,
sales,
ntile(3) over(order by sales desc) buckets
from sales.orders)t;


-- In order to export the data, divide the orders into 2 groups 

select 
ntile(2) over(order by orderid) as buckets,
*
from sales.orders;


-- Find the products that fall within the highest 40 % of prices;

select *,
concat(dist_rank*100,'%') Dist_rank_percent
from(
select 
	product, 
	price,
	cume_dist() over(order by price desc) as dist_rank
from sales.products)t 
where dist_rank <=0.4

