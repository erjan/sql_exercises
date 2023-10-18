'''
  Given the employees and departments table, write a query to get the top 3 highest employee salaries by department. If the department contains less that 3 employees, the top 2 or the top 1 highest salaries should be listed (assume that each department has at least 1 employee). 

Note: The output should include the full name of the employee in one column, the department name, and the salary. The output should be sorted by department name in ascending order and salary in descending order. 
  '''


select department_name, employee_name, salary from (

select 

d.name as department_name, 
concat(first_name, ' ',last_name) as employee_name,
d.id as department_id, salary,

rank()over(partition by d.id order by salary desc) as rnk


 from departments d inner join

 employees e on e.department_id = d.id)k where rnk< 4

 order by department_name, salary desc

