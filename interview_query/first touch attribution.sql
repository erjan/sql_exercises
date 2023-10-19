


'''

The schema below is for a retail online shopping company consisting of two tables, attribution and user_sessions.

The attribution table logs a session visit for each row.

If conversion is true, then the user converted to buying on that session.

The channel column represents which advertising platform the user was attributed to for that specific session.

Lastly the user_sessions table maps many to one session visits back to one user.

First touch attribution is defined as the channel with which the converted user was associated when they first discovered the website.

Calculate the first touch attribution for each user_id that converted. 
'''


with channel_session as
(
select t1.*, t2.channel, t2.conversion
from user_sessions t1
left join attribution t2 on t1.session_id = t2.session_id
)

select channel, user_id
from
(
select *, row_number() over (partition by user_id order by created_at) rn
from channel_session
)a 
where rn = 1 and user_id in (select user_id from channel_session where conversion is True)
