Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.


You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, then the total half-year salary of all employees assigned to the project should not exceed $10K. Salary is defined on a yearly basis, so be careful how to calculate salaries for the projects that last less or more than one year.


Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).


with h as(
select 

title,budget,
(end_date::date - start_date::date)*(sum(salary)/365) as prorated_expenses

from linkedin_projects lp inner join linkedin_emp_projects lep on lp.id = lep.project_id inner join linkedin_employees le on lep.emp_id = le.id

group by title, budget, end_date, start_date)

select title,budget, ceiling(prorated_expenses) as prox from h
where prorated_expenses >budget
order by title 
