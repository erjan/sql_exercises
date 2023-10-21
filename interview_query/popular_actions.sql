



'''
  The events table tracks every time a user performs a certain action (like, post_enter, etc.) on a platform.

Write a query to determine the top 5 actions performed during the week of Thanksgiving (11/22/2020 - 11/28/2020), and rank them based on number of times performed.

The output should include the action performed and their rank in ascending order. If two actions were performed equally, they should have the same rank. 
  '''
  
with h as(
select 
action, 


dense_rank()over( order by count(id)desc ) as ranks
 from events where created_at between '2020-11-22' and '2020-11-28'

group by action)


select 

action , ranks

from h where ranks<=5
