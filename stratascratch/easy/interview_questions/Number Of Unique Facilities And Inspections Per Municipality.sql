Count the number of unique facilities per municipality zip code along with the number of inspections. Output the result along with the number of inspections per each municipality zip code. Sort the result based on the number of inspections in descending order.


select 


facility_zip, count(distinct facility_id), count(serial_number)
from los_angeles_restaurant_health_inspections

group by facility_zip
