Find the average number of points earned per quarterback appearance in each year. Each row represents one appearance of one quarterback in one game. Output the year along with the corresponding average points.
Sort records by the year in descending order.



select 


year, qb, avg(game_points) as x
from qbstats_2015_2016
group by year, qb
order by year desc
