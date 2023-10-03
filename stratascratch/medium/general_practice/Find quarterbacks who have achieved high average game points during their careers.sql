Find quarterbacks who have achieved high average game points during their careers.
Output the quarterback along with the corresponding average points.
Order records by average points in descending order.



select  qb , avg(game_points) as x from qbstats_2015_2016

group by qb order by x desc
