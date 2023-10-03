Write a query to get the list of managers whose salary is less than twice the average salary of employees reporting to them. For these managers, output their ID, salary and the average salary of employees reporting to them.


select 

m1.manager_empl_id,
d1.salary as manager_salary,
avg(d2.salary) as avg_employeesalary

from map_employee_hierarchy 
m1  join dim_employee d1
on d1.empl_id = m1.manager_empl_id
join dim_employee d2 on d2.empl_id = m1.empl_id

group by d1.salary, m1.manager_empl_id
having d1.salary < 2*avg(d2.salary)
