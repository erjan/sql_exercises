
'''
Write a SQL query to select the 2nd highest salary in the engineering department.

Note: If more than one person shares the highest salary, the query should select the next highest salary.
'''


select salary from (
select 
salary,
dense_rank()over(order by salary desc) as rnk
from departments d inner join employees e
on e.department_id = d.id

where d.name = 'engineering')k where rnk = 2

---------------------------------------------------------------------

SELECT salary
    FROM employees
    INNER JOIN departments
        ON employees.department_id = departments.id
    WHERE departments.name = 'engineering'
    GROUP BY 1
    ORDER BY 1 DESC
    LIMIT 1 OFFSET 1
