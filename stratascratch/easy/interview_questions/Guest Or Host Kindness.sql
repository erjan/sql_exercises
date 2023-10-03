
Find whether hosts or guests give higher review scores based on their average review scores. Output the higher of the average review score rounded to the 2nd decimal spot (e.g., 5.11).

select 

from_type,
round(avg(review_score),2) as guest_avg_score
from airbnb_reviews
group by from_type
order by guest_avg_score desc limit 1
