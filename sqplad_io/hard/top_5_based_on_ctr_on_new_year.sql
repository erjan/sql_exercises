/*
Write a query to return the top 5 search terms with the highest click through rate on new year's day (2021-01-01)
The search term has to be searched by more than 2 (>2) distinct users.
Click through rate: number of searches end up with at least one click.
*/


with ctr as (

SELECT 
  query,
  
COUNT(DISTINCT CASE WHEN action = 'click' THEN search.search_id ELSE NULL END) * 100.0/
  COUNT(DISTINCT search.search_id) as tt
from search_result inner join search on search.search_id = search_result.search_id
  where search.date = '2021-01-01'
  group by query
  having count(distinct user_id) >2
)


select query from ctr order by tt desc limit 5

-- i did not solve it myself!


--official solution

WITH click_through_rate AS (
  SELECT 
	  S.query, 
	  COUNT(DISTINCT CASE WHEN action='click' THEN S.search_id ELSE NULL END) * 100/COUNT(DISTINCT S.search_id) ctr  
  FROM 
  search S
  INNER JOIN search_result R
  ON S.search_id = R.search_id
  WHERE S.date = '2021-01-01'
  GROUP BY S.query
  HAVING COUNT(DISTINCT S.user_id) > 2
)
SELECT query
FROM click_through_rate
ORDER BY ctr DESC
LIMIT 5;
