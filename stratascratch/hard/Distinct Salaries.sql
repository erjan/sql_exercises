Find the top three distinct salaries for each department. Output the department name and the top 3 distinct salaries by each department. Order your results alphabetically by department and then by highest salary to lowest.


select distinct department, salary from (
select department, salary,
dense_rank()over(partition by department order by salary desc) as rnk

from twitter_employee

group by department, salary order by department)k where rnk <=3
