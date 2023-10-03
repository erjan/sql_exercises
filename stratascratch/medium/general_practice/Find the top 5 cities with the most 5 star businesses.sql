Find the top 5 cities with the most 5-star businesses. Output the city name along with the number of 5-star businesses.
In the case of multiple cities having the same number of 5-star businesses, use the ranking function returning the lowest rank in the group and output cities with a rank smaller than or equal to 5.


with h as(
select 

city, count(*) as count_of_5_stars, rank()over(order by count(*) desc) as rnk
from yelp_business
where stars = 5
 group by city
 
)

select city, count_of_5_stars from h where rnk<=5 order by count_of_5_stars desc
 
 
