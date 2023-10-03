Find the top 3 medal-winning teams by counting the total number of medals for each event in the Rio De Janeiro 2016 olympics. In case there is a tie, order the countries by name in ascending order. Output the event name along with the top 3 teams as the 'gold team', 'silver team', and 'bronze team', with the team name and the total medals under each column in format "{team} with {number of medals} medals". Replace NULLs with "No Team" string.




with h as(
select team , event, count(medal) as medals_count 

from olympics_athletes_events 
where year =2016  and city = 'Rio de Janeiro' 
and medal is not null

group by team, event),

h2 as(
select 

event, team, medals_count, row_number()over(partition by event order by medals_count desc, team asc) as team_rank
from h)

select event, max(gold_team) as gold_team,
coalesce(max(silver_team), 'No Team') as silver_team,
coalesce(max(bronze_team), 'No Team') as bronze_team

from (
select 
event,
CASE 
            WHEN team_rank = 1 
            THEN team || ' with ' || medals_count || ' medals'
            ELSE NULL 
        END AS gold_team,
        CASE 
            WHEN team_rank = 2
            THEN team || ' with ' || medals_count || ' medals'
            ELSE NULL 
        END AS silver_team,
        CASE 
            WHEN team_rank = 3
            THEN team || ' with ' || medals_count || ' medals'
            ELSE NULL 
        END AS bronze_team
from h2 
where team_rank <=3)k group by event
