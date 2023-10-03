Find the IDs of the drivers who completed at least one trip a month for at least two months in a row.




select 

distinct t1.driver_id
from uber_trips t1 , uber_trips t2 where t1.driver_id = t2.driver_id
and t1.is_completed=TRUE and t2.is_completed =TRUE
and to_char(t1.trip_date + interval '1 month', 'yyyy-mm') = to_char(t2.trip_date, 'yyyy-mm')
