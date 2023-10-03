Find quarterbacks that made most attempts to throw the ball in 2016.
Output the quarterback along with the corresponding number of attempts.
Sort records by the number of attempts in descending order.



select qb, at from (
select 

qb, sum(att) as at, rank()over(order by sum(att) desc)  as rnk
from qbstats_2015_2016 where year = 2016
group by qb order by at desc)k
