You are given a table of users who have been blocked from Facebook, together with the date, duration, and the reason for the blocking. The duration is expressed as the number of days after blocking date and if this field is empty, this means that a user is blocked permanently.
For each blocking reason, count how many users were blocked in December 2021. Include both the users who were blocked in December 2021 and those who were blocked before but remained blocked for at least a part of December 2021.


select block_reason, count(distinct user_id) as n_users 

from fb_blocked_users
 where (extract(year from block_date) = 2021 and extract(month from block_date) = 12) or (block_date < '2021-12-01' and (block_duration is null or (datediff('2021-12-01', block_date)<=block_duration))  )
 
 group by block_reason
