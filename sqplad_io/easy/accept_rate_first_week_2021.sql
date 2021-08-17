/*

Write a query to return the acceptance rate for the first week of 2021 (2021-01-01 - 2021-01-07)
If a friend request is not accepted, the acceptance_dt column is null
*/

-- and this is also the official solution! yay! my own solution = official solution

SELECT 

  SUM( CASE WHEN acceptance_dt is not null THEN 1 ELSE 0 END ) * 1.0 / 
  COUNT(*) AS acceptance_rate
    
FROM request

WHERE request_dt >= '2021-01-01' and request_dt <= '2021-01-07'
