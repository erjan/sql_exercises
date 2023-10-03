Find the old-to-young player ratio for each Olympic games. 'Old' is defined as ages 50 and older and 'young' is defined as athletes 25 or younger. Output the Olympic games, number of old athletes, number of young athletes, and the old-to-young ratio.


with h as(
select games, name, 
(case when age<=25 then 1 else 0 end)as young,

(case when age >=50 then 1 else 0 end) as old

from olympics_athletes_events), 

h2 as(
select games, name , young, old
from h group by games, name, young, old)


select games,  sum(young), sum(old),
sum(old) :: NUMERIC / sum(young) AS old_to_young_ratio from h2 group by games
