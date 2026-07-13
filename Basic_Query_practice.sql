-- Basic query and where operations 

-- 1. Display all columns from sales.employees 

select 
*
from sales.employees;

--2. Display only first name , lastname ,department and salary 

select 
firstname, 
lastname, 
department, 
salary 
from sales.employees;

--3. Display unique departments from employees.

select 
distinct department 
from sales.employees;

--4. Display employees sorted by salary from highest to lowest 

select 
firstname, 
lastname,
department,
salary 
from sales.employees 
order by salary desc;

-- 5. Display the first 3 employees based on highest salary 

select 
firstname, 
lastname,
department, 
salary 
from sales.employees 
order by salary desc 
limit 3;

-- 6. Find employees whose salary is greater then 60000.

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where salary > 60000;

--7. Find employees whose salary is between 50000 and 70000

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where salary between 50000 and 70000;


--8. Find employees who work in the IT department 

select 
firstname,
lastname,
department,
salary 
from sales.employees 
where department ='IT';


-- 9. Find employees who are female 

select 
firstname,
lastname,
department ,
salary ,
gender
from sales.employees
where gender='F';

--10. Find employees whose department is either HR or Finance 

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where department in ('HR','Finance');

--11. Find female employees who work in it 

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where gender = 'F' and department ='IT';


-- 12. Find employees who earn more than 60000 and are male 

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where gender='M' and  salary > 60000;

--13. Find the employees who are not in the it department 

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where department != 'IT';

-- 14 .Find employees whose first name starts with 'A'

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where firstname like 'A%';

--15 . Find employees whose salary is not equal to 50000. 

select 
firstname,
lastname,
department ,
salary 
from sales.employees
where salary !=50000;
