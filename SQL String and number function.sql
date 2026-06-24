--SQL String Function 

-- Show a list of customer's first names together with their country in one column. 

select 
firstname,
country,
concat(firstname,' ',country) as name_country
from sales.customers;

-- Transform the customer's first name to uppercase and last name to lowercase

select 
upper(firstname),
lower(lastname)
from sales.customers;


-- Find customers whose first name contains leading or trailing spaces 

select 
first_name
from customers 
where first_name!=trim(first_name);

-- Remove dashes from a ('123-3232-32243-4')

select 
'123-3232-32243-4' as phone_number,
replace('123-3232-32243-4','-','/') as clean

--Replace FIlE extension from txt to csv 

select 
'report.txt',
replace('report.txt','txt','csv');


-- Calculate the length of each customer's first name

select
first_name,
length(first_name)
from customers;

-- Retrieve the first two characters of each first name .

select 
	first_name,
	left(first_name,2)
from customers;

-- Retrieve the last two characters of each name

select 
first_name,
right(first_name,2)
from customers;


-- Retrieve a list of customers first names removing the first character 

select 
first_name,
substring(trim(first_name),2,length(first_name)) as sub_name
from customers;

-- Round up practice 
select 
3.3232 as number,
round(3.516,2) as round_2,
round(3.516,1) as round_1,
round(3.516,3) as round_3,
round(3.516,0) as round_0


-- ABS 

select 
-10,
abs(-10),
abs(10)
