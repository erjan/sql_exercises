Write a query that returns the company (customer id column) with highest number of users that use desktop only.

SELECT customer_id
FROM
  (SELECT customer_id,
          rank() OVER (
                       ORDER BY count(DISTINCT user_id) DESC)
   FROM fact_events
   WHERE user_id in
       (SELECT user_id
        FROM fact_events
        GROUP BY user_id
        HAVING count(DISTINCT client_id) = 1) AND client_id = 'desktop'
   GROUP BY customer_id) sq
WHERE rank = 1
