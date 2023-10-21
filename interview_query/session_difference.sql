
 '''
   Given a table of user sessions, write a query to get the number of days between each user’s first session and last session for the year 2020. 
   '''

select datediff(max(created_at) , min(created_at)) as no_of_days,
user_id

from user_sessions

where year(created_at) = 2020
group by user_id
