--- SQL Window Functions 

--Find the total sales across all orders 

select
sum(sales) as total_sales
from sales.orders;

-- Find the total sales for each product 

select 
productid,
sum(sales) as total_sales
from sales.orders
group by productid;

-- Find the total sales for each product, additionally provide details such order id and orderdate

select 
	orderid,
	orderdate,
	productid,
	sum(sales) over(partition by productid) as total_sales
from sales.orders


-- Find the total sales acoress all orders and additionally provide details such as orderid, orderdate

select 
orderid,
orderdate,
sum(sales) over() total_Sales
from sales.orders;


-- Find the total sales for each product,
-- ans across all orders
-- additionally provide details such order id and orderdate

select 
	orderid,
	orderdate,
	productid,
	sales,
	sum(sales) over() total_sales,
	sum(sales) over(partition by productid) as total_sales
from sales.orders

-- Find the total sales for each combination of produt and order status

select 
orderid,
productid,
sales,
orderstatus,
sum(sales) over(partition by productid),
sum(sales) over(partition by productid,orderstatus) as salesbyproductandstatus
from sales.orders;

-- Rank each order based on their sales from highest to lowest 
-- additionally provide details such as orderid and orderdate

select 
orderid,
orderdate,
sales,
rank() over(order by sales desc) ranksales
from sales.orders


-- Find the total sales for each order status, only for two prodcuts 101 and 102

select 
orderid,
orderdate,
orderstatus,
sales,
sum(sales) over (partition by orderstatus) total_sales
from sales.orders
where productid in (101,102)

-- Rank customers based on their total Sales

select 
customerid,
sum(sales) total_sales,
rank() over(order by sum(sales) desc)
from sales.orders
group by customerid;
