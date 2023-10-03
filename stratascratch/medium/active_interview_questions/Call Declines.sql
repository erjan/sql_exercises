Which company had the biggest month decline in users placing a call from March to April 2020? Return the company_id and calls variance for the company with the highest decline.


WITH cte AS
  (SELECT c.*,
          company_id
   FROM rc_calls c
   JOIN rc_users u ON c.user_id = u.user_id),
     april_callers AS
     
     
  (SELECT company_id,
          count(DISTINCT user_id) AS april_count
   FROM cte
   WHERE date BETWEEN '2020-04-01' AND '2020-04-30'
   GROUP BY 1),
   
   
     march_callers AS
  (SELECT company_id,
          count(DISTINCT user_id) AS march_count
   FROM cte
   WHERE date BETWEEN '2020-03-01' AND '2020-03-31'
   GROUP BY 1),
   
   
     joined AS
  (SELECT m.company_id,
          COALESCE(april_count, 0) - march_count AS variance
   FROM march_callers m
   LEFT JOIN april_callers a ON m.company_id = a.company_id)
SELECT *
FROM joined
WHERE variance =
    (SELECT MIN(variance)
     FROM joined)
