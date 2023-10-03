Find the number of complaints that ended in a violation.


select vio from (
select 

inspection_type, count(inspection_type),
sum( case when violation_id is not null then 1 else 0 end) as vio
from sf_restaurant_health_violations
group by inspection_type)k where k.inspection_type = 'Complaint'


