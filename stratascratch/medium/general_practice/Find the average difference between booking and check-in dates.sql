Find the average number of days between the booking and check-in dates for AirBnB hosts. Order the results based on the average number of days in descending order.
avg_days_between_booking_and_checkin DESC


select 
id_host,
avg((ds_checkin- cast(ts_booking_at as date) ))
from airbnb_contacts

where ts_booking_at is not null

group by id_host
