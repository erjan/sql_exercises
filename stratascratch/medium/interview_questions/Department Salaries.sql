Find the number of male and female employees per department and also their corresponding total salaries.
Output department names along with the corresponding number of female employees, the total salary of female employees, the number of male employees, and the total salary of male employees.

select 

department,
sum(case when sex = 'F' then 1 else 0 end) fem,
sum(case when sex = 'M' then 1 else 0 end) male,

sum(case when sex = 'F' then salary else 0 end) as fem_sal,
sum(case when sex = 'M' then salary else 0 end) as mal_sal

from employee

group by department
