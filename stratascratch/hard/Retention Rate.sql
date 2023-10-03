Find the monthly retention rate of users for each account separately for Dec 2020 and Jan 2021. Retention rate is the percentage of active users an account retains over a given period of time. In this case, assume the user is retained if he/she stays with the app in any future months. For example, if a user was active in Dec 2020 and has activity in any future month, consider them retained for Dec. You can assume all accounts are present in Dec 2020 and Jan 2021. Your output should have the account ID and the Jan 2021 retention rate divided by Dec 2020 retention rate.


WITH dec_2020 AS
  (SELECT DISTINCT account_id,
                   user_id
   FROM sf_events
   WHERE EXTRACT(MONTH
                 FROM date) = 12
     AND EXTRACT(YEAR
                 FROM date) = 2020 ),
     jan_2021 AS
  (SELECT DISTINCT account_id,
                   user_id
   FROM sf_events
   WHERE EXTRACT(MONTH
                 FROM date) = 1
     AND EXTRACT(YEAR
                 FROM date) = 2021 ),
     max_date AS
  (SELECT user_id,
          MAX(Date) AS max_date
   FROM sf_events
   GROUP BY user_id),
     retention_dec_2020 AS
  (SELECT account_id,
          SUM(CASE
                  WHEN max_date > '2020-12-31' THEN 1.0
                  ELSE 0
              END) / COUNT(*) * 100.0 AS retention_dec
   FROM dec_2020
   JOIN max_date ON dec_2020.user_id = max_date.user_id
   GROUP BY account_id),
     retention_jan_2021 AS
  (SELECT account_id,
          SUM(CASE
                  WHEN max_date > '2021-01-31' THEN 1.0
                  ELSE 0
              END) / COUNT(*) * 100.0 AS retention_jan
   FROM jan_2021
   JOIN max_date ON jan_2021.user_id = max_date.user_id
   GROUP BY account_id)
SELECT retention_jan_2021.account_id,
       retention_jan / retention_dec AS retention
FROM retention_jan_2021
INNER JOIN retention_dec_2020 ON retention_jan_2021.account_id = retention_dec_2020.account_id
