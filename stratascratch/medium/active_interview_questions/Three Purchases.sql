List the IDs of customers who made at least 3 orders in both 2020 and 2021.



SELECT user_id
FROM amazon_orders
WHERE extract(YEAR
              FROM order_date) = 2021
  AND user_id IN
    (SELECT user_id
     FROM amazon_orders
     WHERE extract(YEAR
                   FROM order_date) = 2020
     GROUP BY user_id
     HAVING COUNT(*) >= 3)
GROUP BY user_id
HAVING COUNT(*) >= 3
