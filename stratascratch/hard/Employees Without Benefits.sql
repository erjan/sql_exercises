Find the ratio between the number of employees without benefits to total employees. Output the job title, number of employees without benefits, total employees relevant to that job title, and the corresponding ratio. Order records based on the ratio in ascending order.


with h as(
select 

jobtitle,
sum(case when benefits = 0 or benefits is null then 1 else 0 end) as no_employees_without_benefits,
count(*) as total_people


from sf_public_salaries
group by jobtitle)


select jobtitle,
no_employees_without_benefits,
total_people,
no_employees_without_benefits/total_people::float as rto

from h
