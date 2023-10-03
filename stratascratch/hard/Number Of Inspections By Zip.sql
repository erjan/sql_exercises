Find the number of inspections that happened in the municipality with postal code 94102 during January, May or November in each year.
Output the count of each month separately.

with h as(
select *, extract(year from inspection_date)as year, 
extract(month from inspection_date) as month
from sf_restaurant_health_violations 
where business_postal_code = 94102 and extract(month from inspection_date) in (1,5,11) ),

h2 as(
select  year, month, 
count(inspection_id) as cnt 
from h  group by  year, month)

select year, 
sum(case when month = 1 then cnt else 0 end) as jan,
sum(case when month = 5 then cnt else 0  end) as may,
sum(case when month = 11 then cnt else 0  end) as nov

from h2 group by year
