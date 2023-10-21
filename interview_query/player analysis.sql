'''
You’ve been asked to analyze the player’s behaviors at a gaming company.

Write a query to get the number of players who played between 5 and 10 games (5 and 10 excluded), and the number of players who played 10 games or more.
'''

#my solution

with h as(

SELECT 

id, sum(games_played) as total_games_played 

FROM players

group by id)



select sum(more10)as players_10_plus_games, sum(btw510)as players_more_than_5_to_10_games from(

select 
id,
case when total_games_played>=10 then 1  else 0 end as more10,
case when total_games_played>5 and total_games_played<10 then 1  else 0 end as btw510
from h )k


---------------------------
SELECT 
sum(case when games_played >5 and games_played < 10 then 1 else 0 end)
as "players_more_than_5_to_10_games",
sum(case when games_played >=10  then 1 else 0 end)
as "players_10_plus_games"
FROM players
