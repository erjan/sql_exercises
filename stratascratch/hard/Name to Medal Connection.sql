Find the connection between the number of letters in the athlete's first name and the number of medals won for each type for medal, including no medals. Output the length of the name along with the corresponding number of no medals, bronze medals, silver medals, and gold medals.


with h as(
select 

length((string_to_array(name,' '))[1]) as length_of_name,

case when medal is null then 'no medal' else medal end as medal
from olympics_athletes_events)

select 
length_of_name, 
sum(case when medal = 'no medal' then 1 else 0 end) as no_medals,
sum(case when medal = 'Bronze' then 1 else 0 end) as bronze_medals,
sum(case when medal = 'Gold' then 1 else 0 end) as gold_medals,
sum(case when medal = 'Silver' then 1 else 0 end) as silver_medals

from h 

group by length_of_name
