Find the number of medals earned in each category by Chinese athletes from the 2000 to 2016 summer Olympics. For each medal category, calculate the number of medals for each olympic games along with the total number of medals across all years. Sort records by total medals in descending order.


with h as(
select 
year, medal,
count(*) as n_medals
from olympics_athletes_events
where year IN (2000, 2004, 2008, 2012, 2016)
and team = 'China'
and medal is not null
group by year,medal)



select medal, 
sum(case when year = 2000 then n_medals else 0 end) as medals_2000,
sum(case when year = 2004 then n_medals else 0 end) as medals_2004,
sum(case when year = 2008 then n_medals else 0 end) as medals_2008,
sum(case when year = 2012 then n_medals else 0 end) as medals_2012,
sum(case when year = 2016 then n_medals else 0 end) as medals_2016,
sum(n_medals) as total_medals
from h

group by year,medal

