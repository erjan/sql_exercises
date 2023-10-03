Find employees with the same salary.
Output the worker id along with the first name and the salary.


select 
distinct 
w1.worker_id, w1.first_name, w1.salary

from worker w1 join worker w2 on w1.salary = w2.salary and w1.worker_id <> w2.worker_id
