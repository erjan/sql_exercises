Find the top 3 sectors in the United States with highest average rank. Output the average rank along with the sector name.



with h as(
select 

sector, avg(rank) as avg_rank, rank()over(order by avg(rank) ) as rnk
from forbes_global_2010_2014 where country ='United States'
group by sector)


select sector, avg_rank from h 



