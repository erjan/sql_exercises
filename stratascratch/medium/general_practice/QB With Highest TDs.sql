Find the quarterback who had the highest number of touchdowns (column 'td') in 2016. Output all the quarterbacks along with the corresponding number of TDs. But sort the records based on the number of TDs in descending order.


select qb, x from (
select 

qb, sum(td) as x, rank()over(order by sum(td) desc)as rnk

from qbstats_2015_2016 where year = 2016

group by qb order by x desc)k
