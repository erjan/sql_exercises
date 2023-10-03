Find the duplicate records in the dataset.
Output the worker title, affected_from date, and the number of times the records appear in the dataset.


select 

worker_title, affected_from,  count(*)

from title
group by worker_title, affected_from
having count(*)>1
