You have a dataset of wines. Find the total revenue made by each winery and variety that has at least 90 points. Each wine in the winery, variety pair should be at least 90 points in order for that pair to be considered in the calculation.


Output the winery and variety along with the corresponding total revenue. Order records by the winery in ascending order and total revenue in descending order.


select 

winery, variety,
sum(price)

from winemag_p1

group by winery, variety

having min(points) >=90
