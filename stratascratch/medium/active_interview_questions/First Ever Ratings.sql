Looking at Dashers completing their first-ever order: what percentage of Dashers' first-ever orders have a rating of 0?


with first_ratings as(
select 
*,
first_value(delivery_rating)over(partition by dasher_id order by order_placed_time) as first_rating
from delivery_orders)


select 100.0*(select count(distinct dasher_id) from first_ratings where first_rating = 0)/(select count(distinct dasher_id) from first_ratings)  as perc_zero_rating

