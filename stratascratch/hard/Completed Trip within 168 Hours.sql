An event is logged in the events table with a timestamp each time a new rider attempts a signup (with an event name 'attempted_su') or successfully signs up (with an event name of 'su_success').


For each city and date, determine the percentage of signups in the first 7 days of 2022 that completed a trip within 168 hours of the signup date.






with success_signups as(
select *, timestamp::date as signup_date from signup_events s 
where event_name = 'su_success' 
and timestamp::date between '2022-01-01' and '2022-01-07'),

completed_trips_7_days as(
select distinct driver_id from signup_events s inner join trip_details t on 
s.rider_id = t.driver_id where status = 'completed' 
and extract(epoch from  actual_time_of_arrival - timestamp)/3600 <=168),


h3 as(
select signup_date,city_id, 
cast(count(distinct driver_id) as float) as drivers_who_completed_trips, 
count(distinct rider_id) as drivers_who_signed_up

from success_signups s1 left join completed_trips_7_days s2
on s1.rider_id = s2.driver_id
group by signup_date,city_id)


select city_id, signup_date, 

(drivers_who_completed_trips/drivers_who_signed_up) * 100.0 as rate

from h3
