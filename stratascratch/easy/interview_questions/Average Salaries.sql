Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees along with the average salary of that department.


select 

department, first_name, salary,
avg(salary)over(partition by department) as avg_salary
from employee

