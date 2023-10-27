A marketing team wants to compute a weighted average score to measure the effectiveness of their past email campaigns. They want the weight of the open rate to be 0.3, and the weight of the click rate to be 0.7.

Write a SQL query to calculate the weighted average for each campaign.

Notes: The click rate is the number of clicks over the number of users. The weighted average should be rounded to two decimal places.


SELECT campaign_name, round(0.3*num_opens/num_users+0.7*num_clicks/num_users,2)
as weighted_avg
 FROM email_campaigns
