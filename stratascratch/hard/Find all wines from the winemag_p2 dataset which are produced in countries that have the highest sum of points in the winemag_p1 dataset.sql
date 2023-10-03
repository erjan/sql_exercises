Find all wines from the winemag_p2 dataset which are produced in the country that have the highest sum of points in the winemag_p1 dataset.


with h as(
select country, p from(
select 
country, sum(points) as p, 
rank()over(order by sum(points) desc) as rnk
from winemag_p1 group by country)k where rnk = 1)



select * from winemag_p2 p2 where p2.country = (select country from h)
