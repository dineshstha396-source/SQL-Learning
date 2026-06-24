-- SQl Practice 


/* 1. List all first names from the customers table and the employees table in one column, removing any duplicate names.

Requirements:

Use a set operator.
Output only one column.
Duplicate names should appear only once.
*/

select 
firstname 
from sales.customers
union -- to join without duplicates
select 
firstname 
from sales.employees;

/* 2. List all first names from the customers table and the employees table in one column, but this time keep duplicates.

Requirements:

Use a set operator.
Output only one column.
If the same name appears multiple times, show all occurrences.
*/

select 
firstname 
from sales.customers
union all-- to join with duplicates
select 
firstname 
from sales.employees;

/* 3. Find the customer IDs of customers who have never placed an order.

Requirements
Use a set operator (EXCEPT).
Return only one column: customerid.
Do not use joins.
*/

-- checking table data

select * from sales.customers;
select * from sales.orders;
-- Main logic
select 
customerid 
from sales.customers -- we will get only customerid which is in customer tabel but not order table 
except
select 
customerid 
from sales.orders;


/* 4. Find the customer IDs of customers who:

Have a score greater than 500
Have placed at least one order
Requirements
Use a set operator.
Do not use joins.
Return only customerid.
*/

select 
customerid 
from sales.customers 
where score>500 -- To filter customer with score greater than 500
intersect -- to join customer with order only
select 
customerid 
from sales.orders;


/* 5. Find all customer IDs that:

Have placed an order with sales > 500
But have not placed any order in ordersarchive
Requirements:
Use a set operator.
Do not use joins.
Return only customerid.
*/


select 
customerid 
from sales.orders
where sales>500
except 
select 
customerid 
from sales.ordersarchive;


/* 6. Find customer IDs that appear in all three tables:

sales.customers
sales.orders
sales.ordersarchive
Requirements:
Use set operators only.
No joins.
Return only customerid.
*/

select 
customerid 
from sales.customers
intersect
select 
customerid 
from sales.orders
intersect
select 
customerid 
from sales.ordersarchive;

/* 7. 
Find all customer IDs that:

Exist in customers
Have never placed an order
Have a score greater than 300

Requirements:

Use set operators.
No joins.
Return only customerid.
*/

select 
customerid 
from sales.customers 
where score>300 -- To filter customer with score greater than 300
except -- to join customer without any order
select 
customerid 
from sales.orders;

/* 8. Create a result that shows all unique customerid values involved in the business from:

sales.customers
sales.orders
sales.ordersarchive

But exclude any customerid that appears in ordersarchive.

Requirements:

Use set operators only.
No joins.
Return only customerid.
*/

select 
customerid 
from sales.customers
union 
select 
customerid 
from sales.orders
except
select 
customerid 
from sales.ordersarchive;

/* 9. Find the countries where:

The total sales from orders is greater than 1000
But the country does not have any customer with a score below 500

Requirements:

Use set operators.
No subquery.
No joins.
Return only country.
*/

-- checking table data 
select * from sales.customers;
select * from sales.orders;


select 
customerid 
from sales.customers 
intersect
select
customerid 
from sales.orders
group by customerid
having sum(sales)<5000 and sum(sales)>1000 -- To filter customer with sales not greater than 5000 and greater than 1000;

/* 10. Find customer IDs who:

Have total sales greater than 1000
Have placed orders
But are not present in ordersarchive

Requirements:

Use GROUP BY
Use HAVING
Use set operators
No joins
Return only customerid
*/


select
customerid 
from sales.customers
intersect -- as the orders table can have wrong data of having record who are not customers 
select
customerid 
from sales.orders
group by customerid
having sum(sales)>1000
except 
select 
customerid 
from sales.ordersarchive;

