/*
Write a query to return the same day friend requests acceptance rate on new year's day (2021-01-01)
If a friend request is not accepted, the acceptance_dt column is null

here i forgot to use sum, i was using count instead of sum and it's the same day ,so no need to count difference in days like accept_dt - request_dt
*/


SELECT 
  SUM(CASE WHEN acceptance_dt = request_dt THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS same_day_acceptance_rate
FROM request
WHERE request_dt = '2021-01-01'
