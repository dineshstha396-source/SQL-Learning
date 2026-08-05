-- SQL Sub Query


--1. Find customers whose score is greater than the average customer score 

 select 
 customerid, 
 firstname, 
 score 
 from sales.customers 
 where score > ( 
 	select avg(score) from sales.customers);


-- 2. Find customers whose score is greater than the average score of customers from USA only.
 select 
 customerid, 
 firstname, 
 country,
 score
 from sales.customers 
 where score > ( 
 	select avg(score) from sales.customers where country='USA') ;


--3.Find employees whose salary is greater than the average salary of employees in the IT department.

select 
employeeid, 
firstname , 
department , 
salary 
from sales.employees 
where salary > (
	select avg(salary) from sales.employees where department='IT'
);

--4. Find customers whose total purchase amount is greater than the average customer total purchase amount.

select 
customerid, 
sum(sales) as total_sales 
from sales.orders 
group by customerid
having sum(sales)>(
	select avg(total_sales)
	from (
select customerid, 
sum(sales) as total_sales
from sales.orders group by customerid
	) t
);

--5. Find the top 3 customers by total sales.

select 
customerid, 
total_sales
from (
	select 
	customerid, 
	sum(sales) as total_sales
	from sales.orders 
	group by customerid 
)t
order by total_sales desc
limit 3;

--6. Find employees whose salary is greater than the average salary of their department.

select 
ee.employeeid, 
ee.firstname, 
ee.department, 
ee.salary 
from sales.employees as ee
where salary > (
select avg(e.salary) from sales.employees as e where e.department = ee.department
);

--7. Find customers who have never placed an order.

select 
c.customerid, 
c.firstname, 
c.country, 
c.score 
from sales.customers as c
where not exists  (
	select 1 
	from sales.orders as o
	where o.customerid=c.customerid
)


/*
8. Find customers who:

Have placed at least one order
Their total purchase amount is greater than the average customer purchase amount
*/

select 
c.customerid, 
c.firstname 
from sales.customers as c
where exists (
	select 1 
	from sales.orders as o 
	where o.customerid=c.customerid 
	group by customerid
	having sum(o.sales)> (
				select 
				avg(total_sales) 
				from (
					select 
					sum(sales) as total_sales
					from sales.orders 
					group by customerid
				)t
	)
)

--9. Find products whose price is higher than the average price of their category.

select 
p.*
from sales.products as p
where p.price > (
	select avg(pp.price) from 
	sales.products as pp 
	where pp.category=p.category
);

--10. Find products that are the most expensive product in their category.

select 
p.*
from sales.products as p
where p.price = (
	select max(pp.price) from 
	sales.products as pp 
	where pp.category=p.category
);

--11.Find employees who have the highest salary in their department.

select 
e.*
from sales.employees as e
where e.salary=  (
	select max(ee.salary) from 
	sales.employees as ee
	where ee.department=e.department
);

--12. Find products that have a price above their category average and belong to a category whose average price is above 500.

select 
p.*
from sales.products as p
where p.price > (
	select avg(pp.price) from 
	sales.products as pp 
	where pp.category=p.category
) and category in
(
	select ppp.category
	from sales.products as ppp 
	group by category
	having avg(ppp.price) >500
);




-- Other Sub Query practice 

-- Find orders whose sales amount is greater than the average sales amount

select 
orderid, 
orderdate, 
sales 
from sales.orders 
where sales > (
    select avg(sales)
    from sales.orders
);


-- Find employees who earn more than employee "John".

select 
employeeid, 
firstname, 
department, 
salary 
from sales.employees 
where salary > (
    select max(salary) 
    from sales.employees 
    where firstname='John'
);


-- Find all products that cost more than the cheapest product

select 
productid, 
category,
product,
price 
from sales.products 
where price > (
    select min(price) 
    from sales.products
);


-- Find customers who placed at least one order.

select 
c.customerid,
c.firstname,
c.country
from sales.customers as c
where customerid in (
    select o.customerid 
    from sales.orders as o
);


-- Find customers who never placed an order.

select 
c.customerid,
c.firstname
from sales.customers as c
WHERE NOT EXISTS (
SELECT 1
FROM sales.orders o
WHERE o.customerid=c.customerid
);


-- Find products that have never been ordered.

select
p.productid, 
p.product,
p.category, 
p.price 
from sales.products as p 
where p.productid not in (
    select distinct o.productid 
    from sales.orders as o
);


-- Find employees who sold at least one product.

select 
e.employeeid, 
e.firstname, 
e.salary 
from sales.employees as e
where e.employeeid in (
    select distinct o.salespersonid 
    from sales.orders as o
);


-- Find employees who never made any sale.

select 
e.employeeid, 
e.firstname, 
e.salary 
from sales.employees as e
where e.employeeid not in (
    select distinct o.salespersonid 
    from sales.orders as o
);


-- Find customers who purchased products from category 'Electronics'.

select *
from sales.customers as c
where c.customerid in (
    select distinct
    o.customerid
    from sales.orders as o 
    where o.productid in (
        select distinct p.productid 
        from sales.products as p 
        where p.category ='Electronics'
    )
);


-- Find products purchased by customers from Germany.

select 
*
from sales.products as p
where p.productid in (
    select 
    o.productid 
    from sales.orders as o
    where o.customerid in (
        select c.customerid 
        from sales.customers as c
        where country='Germany'
    )
);


-- Find countries having customers who placed at least one order.

select distinct
c.country
from sales.customers as c
where c.customerid in (
    select distinct o.customerid 
    from sales.orders as o
);


-- Find products that were ordered more than once.

select *
from sales.products as p 
where p.productid in (
    select o.productid 
    from sales.orders as o 
    group by o.productid 
    having count(o.orderid)>1
);


-- Find customers who bought product "Laptop".

select *
from sales.customers as c
where c.customerid in (
    select o.customerid 
    from sales.orders as o 
    where o.productid =(
        select p.productid
        from sales.products as p
        where product='Laptop'
    )
);


-- Find customers whose total sales are above the average total sales of all customers.

select 
c.customerid, 
c.firstname,
c.country,
sum(o.sales) as total_sales
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid
group by c.customerid
having sum(o.sales) > (
    select sum(sales)/count(distinct customerid) 
    from sales.orders
);


-- Find employees whose salary is above the average salary of their department.

select 
*
from sales.employees as e
where salary > (
    select avg(salary) 
    from sales.employees as emp 
    where emp.department=e.department
);


-- Find the highest-paid employee in each department.

select 
*
from sales.employees as e
where salary = (
    select max(salary) 
    from sales.employees as emp 
    where emp.department=e.department
);


-- Find products priced above the average price of their category.

select 
*
from sales.products as p 
where price > (
    select avg(coalesce(price,0)) 
    from sales.products as pp 
    where pp.category=p.category
);


-- Find customers who placed more orders than the average customer.

select 
c.customerid,
c.firstname, 
c.country,
count(o.orderid) as total_orders
from sales.customers as c
inner join sales.orders as o 
on c.customerid=o.customerid 
group by c.customerid
having count(o.orderid) > (
    select count(orderid)/count(distinct customerid) 
    from sales.orders
);


-- Find orders whose sales amount is above the customer's average order value.

select o.*
from sales.orders as o
where o.sales > (
    select avg(sales) 
    from sales.orders 
    where customerid=o.customerid
);


-- Find customers who purchased products from category books 

select 
c.*
from sales.customers  as c
where c.customerid in (
	select o.customerid 
	from sales.orders as o 
	inner join sales.products as p 
	on p.productid=o.productid
	where p.category='Books'
);

-- Find products that have never appeared in any order 

select 
p.* 
from sales.products as p 
where not exists(
	select 1
	from sales.orders as o
	where o.productid=p.productid
);


--Find customers whose total spending is below the average customer spending.

select 
t.*
from (
	select 
	c.customerid,
	c.firstname,
	sum(o.sales) as total_spending
	from sales.orders as o 
	inner join sales.customers as c 
	on c.customerid=o.customerid
	group by c.customerid,c.firstname
)t
where t.total_spending <(
	select avg(total_spending)
	from (
		select 
		customerid,
		sum(sales) as total_spending 
		from sales.orders 
		group by customerid
	)tt
);


-- Find products whose total sales are higher than the average product total sales 

select 
t.*
from (
	select 
	p.productid, 
	p.product, 
	sum(o.sales) as total_sales
	from sales.products as p
	inner join sales.orders as o 
	on p.productid=o.productid
	group by p.productid,p.product
) t
where t.total_sales > (
	select 
	avg(total_sales) 
	from (
	select 
	o.productid,
	sum(o.sales) as total_sales
	from sales.orders as o
	group by o.productid
	)tt
)

-- Find customers whose total spending is greater than the average spending of customers in their country.
select 
t.*
from (
	select 
	c.customerid,
	c.firstname,
	c.country,
	sum(o.sales) as total_spending
	from sales.orders as o 
	inner join sales.customers as c 
	on c.customerid=o.customerid
	group by c.customerid,c.firstname,c.country
)t
where t.total_spending >(
	select avg(total_spending)
	from (
		select 
		oo.customerid,
		sum(oo.sales) as total_spending,
		cc.country
		from sales.orders as oo
		inner join sales.customers as cc
		on cc.customerid=oo.customerid
		group by oo.customerid,cc.country
	)tt
	where tt.country=t.country
);
