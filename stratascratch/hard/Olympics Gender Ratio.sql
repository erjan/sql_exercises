Find the gender ratio between the number of men and women who participated in each Olympics.
Output the Olympics name along with the corresponding number of men, women, and the gender ratio. If there are Olympics with no women, output a NULL instead of a ratio.


with h as(
select 

games, 
sum(case when sex = 'M' then 1 else 0 end) as total_men,
coalesce(sum(case when sex = 'F' then 1 else 0 end),null) as total_women
from(select distinct year, id, height,sex,games from olympics_athletes_events)t

group by games)


select 
games, total_men,total_women,
case when total_women = 0 then null else 
total_men/total_women::float end as ratio
from h
order by ratio 
