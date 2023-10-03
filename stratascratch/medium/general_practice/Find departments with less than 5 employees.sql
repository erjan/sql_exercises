Find departments with less than 5 employees.
Output the department along with the corresponding number of workers.


select department, count(*) as emp 
from worker group by department
having count(*) < 5
