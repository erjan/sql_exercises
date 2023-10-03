Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.



with help as(

select first_name, department, salary , rank()over(partition by department order by salary desc) as rank_salary from employee 

)

select * from help where rank_salary = 1
