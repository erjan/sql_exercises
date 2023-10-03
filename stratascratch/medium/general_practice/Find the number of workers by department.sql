Find the number of workers by department.
Output the department name along with the corresponding number of workers.
Sort records based on the number of workers in descending order.


select 

count(worker_id) , department
from worker

group by department
