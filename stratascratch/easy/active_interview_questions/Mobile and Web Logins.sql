Count the number of unique users per day who logged in from both a mobile device and web. Output the date and the corresponding number of users.

select 
m.date,
count(distinct m.user_id)

from mobile_logs m join web_logs w on m.date = w.date and m.user_id = w.user_id

group by m.date

