Find the first and last times the maximum score was awarded



select max(activity_date), min(activity_date) from los_angeles_restaurant_health_inspections
where score = (select max(score)
from los_angeles_restaurant_health_inspections)
