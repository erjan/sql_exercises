Write a query that returns the number of unique users per client per month



select 

client_id, count(distinct user_id),
extract(month from time_id) as month

from fact_events
group by extract(month from time_id) , client_id
