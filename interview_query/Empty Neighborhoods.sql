





'''
  Whenever the question asks about finding values
  with 0 something (users, employees, posts, etc..) immediately think of the concept of LEFT JOIN! An 
  inner join finds any values that are in both tables, a left join keeps only the values in the left table.

Our predicament is to find all the neighborhoods
  without users. To do this, we must do a left join from the neighborhoods table 
  to the users table which will give us an output like this:
  '''


select name from (
select 


n.name, n.id, count(  u.id  ) as living_users


from neighborhoods n left join users u
on n.id = u.neighborhood_id

group by n.name, n.id)k where living_users = 0

------------------------------------------------------
  #official
SELECT n.name   
FROM neighborhoods AS n 
LEFT JOIN users AS u
    ON n.id = u.neighborhood_id
WHERE u.id IS NULL
