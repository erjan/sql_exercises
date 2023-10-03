Write a query to find which gender gives a higher average review score when writing reviews as guests. Use the from_type column to identify guest reviews. Output the gender and their average review score.


select gender, avg(review_score)  as avgr from airbnb_reviews ar  join airbnb_guests ag on ar.from_user = ag.guest_id
where from_type = 'guest'

group by gender

order by avgr desc limit 1
