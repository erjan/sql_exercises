For every year, find the worst business in the dataset. The worst business has the most violations during the year. You should output the year, business name, and number of violations.


with h as(
select 
*,
extract(year from inspection_date) as year
from sf_restaurant_health_violations),

h2 as(
select 
business_name, year, count(violation_id) as x
from h group by year, business_name order by x desc),

h3 as(
select business_name,year,x, 
row_number()over(partition by year order by x desc) as rnk from h2 )

select * from h3 where rnk = 1


