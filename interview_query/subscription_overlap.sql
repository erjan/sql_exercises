

'''
Given a table of product subscriptions with a subscription start date and end date for each user, write a query that returns true or false whether or not each user has a subscription date range that overlaps with any other completed subscription.

Completed subscriptions have end_date recorded.
'''

  
  
SELECT
    s1.user_id
    , MAX(CASE WHEN s2.user_id IS NOT NULL THEN 1 ELSE 0 END) AS overlap
FROM subscriptions AS s1
LEFT JOIN subscriptions AS s2
    ON s1.user_id != s2.user_id
        AND s1.start_date <= s2.end_date
        AND s1.end_date >= s2.start_date
GROUP BY 1
