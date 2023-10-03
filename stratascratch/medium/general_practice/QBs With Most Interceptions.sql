Find quarterbacks with the most interceptions in 2016. Output the quarterbacks along with the corresponding number of interceptions. Sort records by the interceptions in descending order.


select qb, sum(int) from qbstats_2015_2016 where  year = 2016
group by qb
