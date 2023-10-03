Find the top 5 least paid employees for each job title.
Output the employee name, job title and total pay with benefits for the first 5 least paid employees. Avoid gaps in ranking.


with h as(
select 
employeename,jobtitle,
totalpaybenefits,
dense_rank()over(partition by jobtitle order by totalpaybenefits asc) as rnk

from sf_public_salaries)

select * from h where rnk<=5
