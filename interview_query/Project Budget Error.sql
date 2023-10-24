
'''
We’re given two tables. One is named projects and the other maps employees to the projects they’re working on. 

We want to select the five most expensive projects by budget to employee count ratio. But let’s say that we’ve found a bug where there exist duplicate rows in the employee_projects table.

Write a query to account for the error and select the top five most expensive projects by budget to employee count ratio.

'''

select

(p.budget)/count(distinct e.employee_id) as budget_per_employee,
title
 from employee_projects e join projects p 
 on e.project_id = p.id

 group by p.id 
 order by (p.budget)/count(distinct employee_id) 
 desc limit 5
