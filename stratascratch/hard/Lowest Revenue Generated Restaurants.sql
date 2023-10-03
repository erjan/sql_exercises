Write a query that returns a list of the bottom 2% revenue generating restaurants. Return a list of restaurant IDs and their total revenue from when customers placed orders in May 2020.


You can calculate the total revenue by summing the order_total column. And you should calculate the bottom 2% by partitioning the total revenue into evenly distributed buckets.


with h as(
select restaurant_id, sum(order_total) as total from doordash_delivery
where
customer_placed_order_datetime 
between '2020-05-01' and '2020-05-31'

group by restaurant_id
order by total desc)

select restaurant_id, total from (
select  restaurant_id,total,
ntile(50)over(order by total ) as x
from h)k where  x =1
