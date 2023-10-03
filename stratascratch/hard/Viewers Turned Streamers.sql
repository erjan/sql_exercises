From users who had their first session as a viewer, how many streamer sessions have they had? Return the user id and number of sessions in descending order. In case there are users with the same number of sessions, order them by ascending user id.


with h as(
select user_id, session_id, session_start,session_type, rnk from(
select 

user_id, session_id,session_start,session_type,
rank()over(partition by user_id order by session_start asc) as rnk

from twitch_sessions

group by user_id, session_id, session_start,session_type)k where rnk = 1
and session_type = 'viewer')


select 

h.user_id,
sum(case when t.session_type = 'streamer' then 1 else 0 end) as n_sessions
from h join twitch_sessions t on h.user_id = t.user_id 
group by h.user_id
order by h.user_id asc
