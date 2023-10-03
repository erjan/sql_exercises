Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.

select distinct e1.first_name, e1.salary 

from employee e1 left join employee e2 on e1.manager_id = e2.id

where e1.salary > e2.salary
