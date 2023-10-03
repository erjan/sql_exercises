Find whether quarterbacks performed better at home or away in 2016.
Output the quarterback along with the corresponding maximum home and away points.



select 
qb, 
max(game_points)filter(where home_away='away') as away_points,
max(game_points)filter(where home_away='home') as home_points

from qbstats_2015_2016 where year = 2016
group by qb
