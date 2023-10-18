'''
  Let’s say we are given a table user_logins.

Using this table, calculate how many users logged in an identical number of times on January 1st, 2022.

For example, it may be the case that on that date three users logged in seven times, four users logged in five times, two users logged in ten times, etc.
  '''




with h as(

Let’s say we are given a table user_logins.

Using this table, calculate how many users logged in an identical number of times on January 1st, 2022.

For example, it may be the case that on that date three users logged in seven times, four users logged in five times, two users logged in ten times, etc.
  
  
  
  SELECT id,user_id, 
login_date
 FROM user_logins 
 
where date_format(login_date, '%Y-%m-%d')='2022-01-01'),


h2 as(
select user_id, count(id) as number_of_logins
from h
group by user_id)


select number_of_logins, 
count(user_id) as number_of_users

 from h2
group by number_of_logins


