You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.


The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.


SELECT count(DISTINCT user_id)
FROM marketing_campaign
WHERE user_id in
    (SELECT user_id
     FROM marketing_campaign
     GROUP BY user_id
     HAVING count(DISTINCT created_at) >1
     AND count(DISTINCT product_id) >1)
  AND concat((user_id),'_', (product_id)) not in
    (SELECT user_product
     FROM
       (SELECT *,
               rank() over(PARTITION BY user_id
                           ORDER BY created_at) AS rn,
               concat((user_id),'_', (product_id)) AS user_product
        FROM marketing_campaign) x
     WHERE rn = 1 )
