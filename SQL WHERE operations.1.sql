-- SQL WHERE Operations 

-- 1. Retrieve all customers from Germany 

select 
* 
from customers
where country='Germany';


--2. Retrieve all customers who are not from Germany 

select 
* 
from customers 
where country !='Germany';


--3. Retrieve all customers with score greater than 500.

select 
*
from customers 
where score > 500;

--4. Retrieve all customers with score of 500 or more 

select 
*
from customers 
where score >=500;

--5. Retrieve all customers with score less than 500 

select 
*
from customers
where score<500;

--6. Retrieve all customers with score of 500 or less

select 
* 
from customers 
where score <=500;


--7. Retrieve all customers who are from USA and have a score greater than 500.

select 
*
from customers 
where score >500 and country='USA';

--8.  Retrieve all customers who are either from USA or have a score greater than 500.

select 
*
from customers 
where country='USA' or score >500;


--9.  Retrieve all customers with score not less than 500

-- First solution 

select 
*
from customers 
where score >=500;

--Second solution 

select 
*
from customers 
where not score < 500;


--10. Retrieve all customers whose score falls in the range between 100 and 500.

select 
*
from customers 
where score between 100 and 500;


--11.  Retrieve all customers from either Germany or USA.

-- First Solution
select 
*
from customers 
where country='USA' or country='Germany';

-- Second Solution

select
*
from customers 
where country in ('USA','Germany');


--12. Find all customers whose first name starts with 'M'

select 
*
from customers 
where first_name like 'M%';

--13.Find all customers whose first name ends with 'n'.

select 
*
from customers 
where first_name like '%n';

--14. Find all customers whose first name contains 'r'.

select 
*
from customers 
where first_name like '%r%';

--15. Finad all customers whose first name has 'h' in the third position. 

select 
*
from customers 
where first_name like '__h%';