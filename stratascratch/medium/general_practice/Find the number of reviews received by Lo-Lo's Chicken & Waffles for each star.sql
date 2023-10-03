Find the number of reviews received by Lo-Lo's Chicken & Waffles for each star.
Output the number of stars along with the corresponding number of reviews.
Sort records by stars in ascending order.


select 
stars,count(*) as n

from yelp_reviews

  where business_name LIKE 'Lo-Lo_s Chicken & Waffles'
group by stars
order by n
