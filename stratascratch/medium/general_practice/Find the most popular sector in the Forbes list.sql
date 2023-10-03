Find the most popular sector from the Forbes list based on the number of companies in each sector.
Output the sector along with the number of companies.


select 

sector,
count(company) as x
from forbes_global_2010_2014

group by sector order by x desc limit 1
