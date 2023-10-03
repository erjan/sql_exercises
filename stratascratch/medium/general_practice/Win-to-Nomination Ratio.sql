Calculate the win-to-nomination ratio for each nominee. Output the ratio and the nominee's name. Order the results based on the ratio in descending order to show nominees with the highest ratio on top.


with h as(
select 

nominee,
sum(case when winner = TRUE then 1 else 0 end)::float as winner,
count(*)::float as nom
from oscar_nominees

group by nominee)

select nominee, ((winner/nom)::numeric)  as ratio from h
order by ratio desc
-- select * from h
