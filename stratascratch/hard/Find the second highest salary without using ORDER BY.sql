Find the second highest salary without using ORDER BY.

select max(salary) from worker 
 where salary<(
 select max(salary)from
 worker)
