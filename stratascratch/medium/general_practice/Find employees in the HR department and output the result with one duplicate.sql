Find employees in the HR department and output the result with one duplicate.
Output the first name and the department of employees.



select  first_name, department from worker where department = 'HR'
union all
select  first_name, department from worker where department = 'HR'
