Find the most profitable location. Write a query that calculates the average signup duration and average transaction amount for each location, and then compare these two measures together by taking the ratio of the average transaction amount and average duration for each location.


Your output should include the location, average duration, average transaction amount, and ratio. Sort your results from highest ratio to lowest.


with h as (
select 
s.signup_id,
(signup_stop_date -signup_start_date) as duration

from signups s inner join transactions t on s.signup_id = t.signup_id),

 avg_signup_duration as(
select signup_id, avg(duration)
from h group by signup_id),

avg_tr as(
select 
location, avg(amt) avg_transaction_by_location
from signups s inner join transactions t on s.signup_id = t.signup_id

group by location),

h4 as(
select 
s.signup_id,location,
(signup_stop_date -signup_start_date) as duration

from signups s inner join transactions t on s.signup_id = t.signup_id),

avg_signup_duration_by_location as(
select 
location, signup_id, avg(duration) as avg_dur_by_loc
from h4 group by location, signup_id)


select 
a1.location, 
avg(a1.avg_transaction_by_location) as avg_transaction_by_location,
avg(a2.avg_dur_by_loc) as avg_dur_by_loc,

avg(a1.avg_transaction_by_location)/avg(a2.avg_dur_by_loc) as ratio


from avg_tr a1 , avg_signup_duration_by_location a2 where a1.location = a2.location

group by a1.location
order by ratio desc

