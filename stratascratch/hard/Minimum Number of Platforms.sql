You are given a day worth of scheduled departure and arrival times of trains at one train station. One platform can only accommodate one train from the beginning of the minute it's scheduled to arrive until the end of the minute it's scheduled to depart. Find the minimum number of platforms necessary to accommodate the entire scheduled traffic.


with h as(
select train_id, arrival_time as time , 1 as mark from  train_arrivals
union all
select train_id, departure_time as time, -1 as mark from train_departures),

h2 as(
select * from h order by time, mark desc)


select max(trains_at_same_time) as min_platforms from(
select *, sum(mark)over(order by time, mark desc) as trains_at_same_time
from h2)k
