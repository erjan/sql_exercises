

Find the median inspection score of each business and output the result along with the business name. Order records based on the inspection score in descending order.
Try to come up with your own precise median calculation. In Postgres there is percentile_disc function available, however it's only approximation.




with h as(
select 

business_name,
percentile_cont(0.5)within group (order by inspection_score desc) as perc
from sf_restaurant_health_violations

group by business_name order by perc desc)


select  * from h where perc is not null
