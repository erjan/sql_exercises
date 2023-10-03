Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.


with help as(
select 

user_id, date(timestamp) as d,

max(case when action = 'page_load' then timestamp end ) as page_load,

min(case when action = 'page_exit' then timestamp end) as page_exit

from facebook_web_log group by user_id,d)


select user_id, avg(page_exit - page_load) as avg_session_time from help
group by user_id having avg(page_exit - page_load) is not null
