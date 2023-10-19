



'''
We’re given a table of bank transactions with three columns, user_id, a deposit or withdrawal value (determined if the value is positive or negative), and created_at time for each transaction.

Write a query to get the total three-day rolling average for deposits by day.

Note: Please use the format '%Y-%m-%d' for the date in the outout
'''


WITH valid_transactions AS (
   SELECT DATE_FORMAT(created_at, '%Y-%m-%d') AS dt
       , SUM(transaction_value) AS total_deposits
   FROM bank_transactions AS bt
   WHERE transaction_value > 0
   GROUP BY 1
)

SELECT vt2.dt,
   AVG(vt1.total_deposits) AS rolling_three_day
FROM valid_transactions AS vt1
INNER JOIN valid_transactions AS vt2
   -- set conditions for greater than three days
   ON vt1.dt > DATE_ADD(vt2.dt, INTERVAL -3 DAY)
   -- set conditions for max date threshold
       AND vt1.dt <= vt2.dt
GROUP BY 1
