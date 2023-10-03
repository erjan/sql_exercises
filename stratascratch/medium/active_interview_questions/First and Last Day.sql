What percentage of transactions happened on first and last day of the promotion. Segment results per promotion. Output promotion id, percentage of transactions on the first day and percentage of transactions on the last day.

with h as(
select 

f1.promotion_id,

count(product_id)as total,
count(product_id)filter( where date = start_date)as fi,
count(product_id)filter( where date = end_date)as la

from facebook_sales_promotions f1 inner join facebook_sales f2 
on f1.promotion_id = f2.promotion_id

group by f1.promotion_id )

select promotion_id,

fi/total::float*100.0, la/total::float*100.0
from h
