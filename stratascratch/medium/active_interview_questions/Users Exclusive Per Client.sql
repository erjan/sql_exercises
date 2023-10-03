Write a query that returns a number of users who are exclusive to only one client. Output the client_id and number of exclusive users.


select client_id, count(distinct user_id) from fact_events
where user_id in (
select 

user_id
from fact_events
group by user_id
having count(distinct client_id ) = 1)
group by client_id
