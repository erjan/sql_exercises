Find the number of police officers (job title contains substring police), firefighters (job title contains substring fire), and medical staff employees (job title contains substring medical) based on the employee name.
Output each job title along with the corresponding number of employees.

with h as(
select 
employeename,
case when jobtitle ilike '%Police%' then 'Police'
 when jobtitle ilike '%Fire%' then 'Firefighter'
 when jobtitle ilike '%Medical%' then 'Medical' end as company

from sf_public_salaries)


select company, count(*) from h where company is not null
group by company
