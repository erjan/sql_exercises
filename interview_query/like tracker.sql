'''
The events table tracks every time a user performs a certain action (like, post_enter, etc.) on a platform. An example of this table would look like this:

user_id	created_at	action	platform
1	2021-01-01 12:00:00	email_opened	Android
2	2021-01-01 12:05:00	like	Outlook
3	2021-01-01 12:10:00	post_enter	Gmail
4	2021-01-01 12:15:00	post_cancel	Outlook
5	2021-01-01 12:20:00	like	Gmail
What query would you write to determine how many different users gave a like on June 6, 2020?
'''


select 


count(distinct user_id)  as num_users_gave_like

from events


 where  date(created_at) ='2020-06-06' and action = 'like'
