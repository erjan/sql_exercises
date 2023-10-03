Which hour has the highest average order volume per day? Your output should have the hour which satisfies that condition, and average order volume.


with h as(
select 

count(id) n_orders,
order_timestamp_utc::date,
extract(hour from order_timestamp_utc) as hour
from postmates_orders group by 
extract(hour from order_timestamp_utc) , order_timestamp_utc::date ),

h2 as(
select 

hour, avg(n_orders) as avg_orders

from h
group by hour
order by avg_orders desc)


select * from h2 where avg_orders = (select max(avg_orders) from h2) 
