Write a query to calculate the longest period (in days) that the company has gone without hiring anyone. Also, calculate the longest period without firing anyone. Limit yourself to dates inside the table (last hiring/termination date should be the latest hiring /termination date from table), don't go into future.


with h as(
select 
 lag(hire_date,1) over(order by hire_date desc) - hire_date as hire_diff,
 lag(termination_date,1) over(order by termination_date desc) - termination_date as fire_diff
from uber_employees )


select max(hire_diff), max(fire_diff) from h
