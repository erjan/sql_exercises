





/*
Write a query to return DoD(day over day) growth for each store from May 24 (inclusive) to May 31 (inclusive).
DoD: (current_day/ prev_day -1) * 100.0
Multiply dod growth to 100.0 to get percentage of growth.
Use ROUND to convert dod growth to the nearest integer.
*/

-- my solution - i did it myself!


WITH store_daily_rev AS (
  SELECT 
    I.store_id, 
    DATE(P.payment_ts) date,
    SUM(amount) AS daily_rev
  FROM 
    payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id
  WHERE DATE(P.payment_ts) >= '2020-05-01'
  AND DATE(P.payment_ts) <= '2020-05-31'
  GROUP BY I.store_id, DATE(P.payment_ts)
),

h2 as (
SELECT
  store_id, 
  date, 
  daily_rev,
  lag(daily_rev, 1) OVER (partition by store_id ORDER BY date) as prev_daily_rev
FROM
  store_daily_rev
ORDER BY store_id)


-- official solution

WITH store_daily_rev AS (
  SELECT 
    I.store_id, 
    DATE(P.payment_ts) date,
    SUM(amount) AS daily_rev
  FROM 
    payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id
  WHERE DATE(P.payment_ts) >= '2020-05-01'
  AND DATE(P.payment_ts) <= '2020-05-31'
  GROUP BY I.store_id, DATE(P.payment_ts)
)
SELECT 
  store_id,
  date,
  ROUND( (daily_rev / LAG(daily_rev, 1) OVER(PARTITION BY store_id ORDER BY date) -1) * 100.0 ) AS dod_growth
FROM store_daily_rev;


select store_id, date, round((daily_rev / prev_daily_rev -1) * 100.0) as dod
from h2
