
'''
  Given the two tables, write a SQL query that creates a cumulative distribution of the number of comments per user. Assume bin buckets class intervals of one.
  '''

with h as(
SELECT 

u.id as user_id, count(c.user_id) as num_comments


 FROM users u left join comments c on u.id = c.user_id

 group by u.id)



select frequency, sum(total_users)over(order by frequency) as cum_total from(

select num_comments as frequency, count(*) as total_users from h group by num_comments)k
