Find the total number of events a user has triggered and the average number of days between the event date and date of when the user activated.
Your output should include the user_id, event name, the number of events , and the average date between the event dates and the user's activated date.


select 
pu.user_id
,pe.event_name
,sum(case when pe.user_id is not null then 1 else 0 end) event_triggers
,AVG(occurred_at::date - activated_at::date) AS avg_days 
from playbook_users pu
join playbook_events pe
on pu.user_id = pe.user_id
group by 1,2
order by 1
