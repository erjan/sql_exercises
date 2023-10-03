Find the quarterback who threw the longest throw in 2016. Output the quarterback name along with their corresponding longest throw.


The 'lg' column contains the longest completion by the quarterback.


select qb, lg from(
select qb, lg,  rank()over(order by lg desc) as rnk from(

select 
qb,
left(lg,2)::numeric as lg

from qbstats_2015_2016  where year = 2016)k)q where rnk = 1



