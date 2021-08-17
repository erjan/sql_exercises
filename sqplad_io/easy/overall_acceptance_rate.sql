/*
Write a query to return the overall acceptance rate of friend requests.
acceptance rate: number of acceptance divided by number of requests.
Hint: a sender can make multiple requests to the same people, a recipient can accept a request multiple times.
If there are no requests, you should return 0.
*/


with h1 as (
  
  select count(*) as n_ac from (
	select distinct sender_id, recipient_id
	from accepted_request)k
  
  ),
  
  h2 as (
  select count(*) as total from (
  select distinct sender_id, recipient_id from friend_request)b    
  )
  
select h1.n_ac *1.0 / h2.total from h1,h2
  
