Find all workers who are also managers.

Output the first name along with the corresponding title.


select 

first_name, worker_title
from worker w join title t on w.worker_id = t.worker_ref_id and worker_title = 'Manager'
