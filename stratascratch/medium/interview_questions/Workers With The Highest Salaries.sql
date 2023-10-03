Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.

select worker_title from worker w join title t on t.worker_ref_id = w.worker_id

where w.salary = (select max(salary) from worker)
