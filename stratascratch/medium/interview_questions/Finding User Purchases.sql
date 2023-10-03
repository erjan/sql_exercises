Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.

with next_transaction as(
select 
user_id,
created_at, lead(created_at,1)over(partition by user_id order by created_at asc) as next_transaction
from amazon_transactions)

select distinct user_id from next_transaction

where next_transaction - created_at < 8
