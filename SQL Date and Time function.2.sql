-- CAST() / :: Convert a value to a specified data type 
-- syntax : CAST(expression as data_type)

select 
cast('123' as int) as string_to_int,
cast(123 as varchar) as int_to_string,
cast('2025-08-20' as date) as string_to_date,
cast('2025-08-20' as timestamp) as string_to_timestamp,
creationtime,
cast(creationtime as date) as timestamp_to_date
from sales.orders;

--Age() : It is used to calculate the difference between two dates and return the result as interval 

--Calculate the age of mine : My DOB is 2007-01-05

select age(current_date,Date '2007-01-05');

--INTERVAL : It is a data type to represent the time duration


-- Current_date : Give the today date , current_time : Give the present time , now() : give the today date with present time 
select 
current_date as today,
current_time as present_time,
now() as Time_stamp
