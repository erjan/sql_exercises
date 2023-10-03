Find the countries with the most negative reviews. Output the country along with the number of negative reviews and sort records based on the number of negative reviews in descending order. Review is not negative if value negative value column equals to "No Negative". You can ignore countries with no negative reviews.


select reviewer_nationality, 

count(*) as x
from hotel_reviews
where negative_review <> 'No Negative'

group by reviewer_nationality
order by x desc
