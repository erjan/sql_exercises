Find all the users who were active for 3 consecutive days or more.


SELECT a.user_id FROM sf_events a 
JOIN sf_events b ON a.date + 1 = b.date 
JOIN sf_events c ON b.date + 1 = c.date
