Find the median age of gold medal winners across all Olympics.




select percentile_cont(0.5)within group (order by age)

from(select name, age, year from olympics_athletes_events
where medal = 'Gold' group by name, age, year) su
