Find the advertising channel with the smallest maximum yearly spending that still brings in more than 1500 customers each year.


WITH below_1500 AS
  (SELECT advertising_channel
   FROM uber_advertising
   GROUP BY advertising_channel
   HAVING MIN(customers_acquired) > 1500),
     rank_cte AS
  (SELECT u.advertising_channel,
          money_spent,
          dense_rank() OVER (PARTITION BY u.advertising_channel
                             ORDER BY money_spent DESC) AS rnk
   FROM uber_advertising u
   JOIN below_1500 b ON u.advertising_channel = b.advertising_channel)
SELECT advertising_channel
FROM
  (SELECT *
   FROM rank_cte
   WHERE rnk = 1) tmp
WHERE tmp.money_spent =
    (SELECT min(money_spent)
     FROM rank_cte
     WHERE rnk = 1)
