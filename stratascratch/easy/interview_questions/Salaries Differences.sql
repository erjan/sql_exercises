Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.


with helper as (
select max(salary) as s, department from db_dept inner join db_employee on 
db_dept.id = db_employee.department_id
group by department
having department in ('engineering', 'marketing') ),

mark as (
select s from helper where department = 'marketing'
),

eng as (

select s from helper where department = 'engineering'
)

select mark.s - eng.s  from mark , eng
