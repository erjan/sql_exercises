
'''
  Let’s say you work at Uber. You want to learn how long Uber rides are taking for individual users.

Given a rides table, write a query to find the average duration of all rides in minutes. Sort results by passenger_user_id ascending.
  '''

select 
passenger_user_id,

avg(timestampdiff(minute,start_dt,end_dt) ) as avg_time

from rides
group by passenger_user_id

