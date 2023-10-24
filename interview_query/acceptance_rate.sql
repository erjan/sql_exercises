
'''
  We’re given two tables. friend_requests holds all the friend requests made and friend_accepts is all of the acceptances.

Write a query to find the overall acceptance rate of friend requests.

Note: Round results to 4 decimal places.
  '''

select 

cast(count( acceptor_id)/count( fr.requester_id) as decimal(5,4)) as acceptance_rate 

from friend_accepts fa

right join 
friend_requests  fr on fa.requester_id = fr.requester_id
and requested_id = acceptor_id
