Find the number of employees in each department.
Output the department name along with the corresponding number of employees.


select department, count(distinct worker_id) from worker

group by department
