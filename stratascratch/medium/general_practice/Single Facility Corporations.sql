Find all owners which have only a single facility. Output the owner_name and order the results alphabetically.


select 


owner_name

from los_angeles_restaurant_health_inspections

group by owner_id, owner_name

having count(distinct facility_id) = 1
order by owner_name asc
