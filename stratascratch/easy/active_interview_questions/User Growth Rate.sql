Find the growth rate of active users for Dec 2020 to Jan 2021 for each account. The growth rate is defined as the number of users in January 2021 divided by the number of users in Dec 2020. Output the account_id and growth rate.


select (CASE
                           WHEN date BETWEEN '2021-01-01' AND '2021-01-31' THEN user_id
                           ELSE NULL
                       END)  ::float,
                           
 (CASE
                                                          WHEN date BETWEEN '2020-12-01' AND '2020-12-31' THEN user_id
                                                          ELSE NULL
                                                      END))::float
                                                      
SELECT account_id,
       COUNT(DISTINCT (CASE
                           WHEN date BETWEEN '2021-01-01' AND '2021-01-31' THEN user_id
                           ELSE NULL
                       END))::float / COUNT(DISTINCT (CASE
                                                          WHEN date BETWEEN '2020-12-01' AND '2020-12-31' THEN user_id
                                                          ELSE NULL
                                                      END))::float
FROM sf_events
GROUP BY 1
