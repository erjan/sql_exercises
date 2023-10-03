Find the median employee salary of each department.
Output the department name along with the corresponding salary rounded to the nearest whole dollar.

select 

department,
percentile_cont(0.5)within group(order by salary)
from employee
group by department
