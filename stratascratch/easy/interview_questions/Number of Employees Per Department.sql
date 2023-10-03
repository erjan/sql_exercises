Find the number of employees in each department.
Output the department name along with the corresponding number of employees.
Sort records based on the number of employees in descending order.


select 

department,
count(id) x
from employee
group by department
order by x desc
