

'''
  Given a table of user logs with platform information, count the number of daily active users on each platform for the year of 2020.
  '''

select 

platform,
created_at,
count(distinct user_id) as daily_users
from events

where year(created_at) = 2020

group by platform, created_at
