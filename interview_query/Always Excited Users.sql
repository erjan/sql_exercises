
'''
  Let’s say you work at an advertising firm. You have a table of users’ impressions of ad 
  campaigns over time. Each impression_id consists of values of user engagement specified by Excited, OK, and Bored.

Write a query to find all users that are currently “Excited” and have never been “Bored” with a campaign.
  '''


select distinct user_id from ad_impressions a

where impression_id='Excited' 

and a.user_id not in (select user_id from ad_impressions where impression_id= 'Bored')
