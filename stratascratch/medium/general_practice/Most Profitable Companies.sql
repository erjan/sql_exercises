Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.


select company, profits from (
select 
company,profits,
rank()over(order by profits desc) as ranking

from forbes_global_2010_2014)k where ranking <=3

