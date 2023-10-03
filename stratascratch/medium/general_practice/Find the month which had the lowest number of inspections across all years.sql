Find the month which had the lowest number of inspections across all years.
Output the number of inspections along with the month.


select 

extract(month from activity_date) as month,
count(*) as x
from los_angeles_restaurant_health_inspections

group by extract(month from activity_date) order by x asc limit 1
