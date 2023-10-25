'''
Given two tables, search_events and users, write a query to
  find the three age groups (bucketed by decade: age 0-9 falls into group 0, age 10-19 to group 1, …, 90-99 to 
  group 9, with the endpoint included) with the highest clickthrough 
  rate in 2021. If two or more groups have the same clickthrough rate, the older group should have priority.

Hint: If a user that clicked the link on 1/1/2021
  is 29 years old on that day and has a birthday tomorrow 
  on 2/1/2021, they fall into the [20-29] category. If the same 
  user clicked on another link on 2/1/2021, he turned 30 and will fall into the [30-39] category.
'''

with h as(
SELECT 

s.search_id, s.query, s.has_clicked, s.user_id as sid, s.search_time, 
u.id, u.name, u.birthdate, 
timestampdiff(year, birthdate, search_time) as age

FROM search_events s inner join users u
on s.user_id = u.id 
where year(search_time) = 2021),

h2 as(


select 
*,

case 
when age between 0  and 9  then 0
when age between 10 and 19 then 1
when age between 20 and 29 then 2
when age between 30 and 39 then 3
when age between 40 and 49 then 4
when age between 50 and 59 then 5
when age between 60 and 69 then 6
when age between 70 and 79 then 7
when age between 80 and 89 then 8
when age between 90 and 99 then 9 end as age_group

from h

)


select 

age_group,

sum(has_clicked)/count(distinct search_id) as crt

 from h2 
group by age_group
order by crt desc limit 3
-----------------------------------------------------------------------------------------
WITH cte_1 AS (
SELECT 
has_clicked,
TIMESTAMPDIFF(YEAR,birthdate,search_time) DIV 10 AS age_group  FROM users a JOIN search_events b 
ON a.id = b.user_id    WHERE YEAR(search_time) = '2021'
),
cte_2 AS (
SELECT age_group, sum(has_clicked)/count(1) AS clck_rate FROM 
cte_1 group by age_group
)
SELECT age_group, clck_rate AS crt FROM cte_2
ORDER BY clck_rate DESC, age_group DESC
limit 3
