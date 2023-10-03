Given a list of projects and employees mapped to each project, calculate by the amount of project budget allocated to each employee . The output should include the project title and the project budget rounded to the closest integer. Order your list by projects with the highest budget per employee first.


select 

title, round((budget/count( emp_id)::float)::numeric,0)  as budget_emp_ratio 

from ms_projects mp inner join ms_emp_projects mep on mp.id = mep.project_id

group by title, budget

order by budget_emp_ratio desc
