Given the education levels and salaries of a group of individuals, find what is the average salary for each level of education.

select  education, avg(salary) as s from google_salaries group by education order by  s desc;
