For each city, find the number of rides in August 2021 that were not paid for using promotional codes. Output the city or cities where this number was the highest.


select city from (
select 

city, count(lo.order_id) as x, rank()over(order by count(lo.order_id) desc) as rnk
from lyft_orders lo join lyft_payments lp on lo.order_id = lp.order_id

where order_date between '2021-08-01' and '2021-08-31' and promo_code = FALSE
group by city )k where rnk = 1
