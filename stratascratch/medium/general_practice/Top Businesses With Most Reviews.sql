Find the top 5 businesses with most reviews. Assume that each row has a unique business_id such that the total reviews for each business is listed on each row. Output the business name along with the total number of reviews and order your results by the total reviews in descending order.


select 

name,
sum(review_count) review_count

from yelp_business

group by name
order by review_count desc limit 5
