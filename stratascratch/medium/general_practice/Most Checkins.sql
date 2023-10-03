Find the top 5 businesses with the most check-ins.
Output the business id along with the number of check-ins.


select business_id, x from (
select 

business_id, 
sum(checkins) as x,
rank()over(order by sum(checkins) desc) as rnk
from yelp_checkin 
group by business_id ) k where rnk <=5
