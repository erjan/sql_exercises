Find the total salary of each department.
Output the salary along with the corresponding department.


select sum(salary) x , department from worker group by department
order by x desc
