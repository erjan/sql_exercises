Return a list of users with status free who didn’t make any calls in Apr 2020.



select

distinct ru.user_id

from rc_users ru where status = 'free' and ru.user_id not in (select 
user_id from rc_calls rc where date between '2020-04-01' and '2020-04-30')
