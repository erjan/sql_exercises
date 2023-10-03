Find the average number of friends a user has.



with h as(
select 

 user_id, friend_id
from google_friends_network
union
select friend_id as user_id, user_id as friend_id
from google_friends_network)

select avg(x) from (
select user_id, count(distinct friend_id) as x from h group by user_id)k

