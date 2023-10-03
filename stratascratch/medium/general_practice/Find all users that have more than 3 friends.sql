Find all users that have more than 3 friends.



with h as(
select 

user_id as user_id, friend_id
from google_friends_network
union
select friend_id as user_id, user_id as friend_id from google_friends_network)


select 
user_id from h group by user_id having count(distinct friend_id)>3

