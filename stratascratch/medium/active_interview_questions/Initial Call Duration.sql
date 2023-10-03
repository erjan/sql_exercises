Redfin helps clients to find agents. Each client will have a unique request_id and each request_id has several calls. For each request_id, the first call is an “initial call” and all the following calls are “update calls”.  What's the average call duration for all initial calls?


with h as(
select 

request_id, min(id) as created

from redfin_call_tracking

group by request_id)


select avg(call_duration) from redfin_call_tracking
where id in (select created from h)

