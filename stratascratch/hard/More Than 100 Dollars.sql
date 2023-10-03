For each month of 2021, calculate what percentage of restaurants, out of these that fulfilled any orders in a given month, fulfilled more than 100$ in monthly sales?

with h as(
select d.*, extract(month from order_placed_time) as month,
 sales_amount from delivery_orders d inner join order_value o
on o.delivery_id =d.delivery_id

where extract(year from order_placed_time) =  2021),


rest_with_min_1_order_and_100_monthlysales as(

select 
restaurant_id,month,sum(sales_amount) as total_monthly,

sum(sales_amount)>100 as more100, 


count(h.delivery_id)
from h
group by restaurant_id, month
having count(h.delivery_id) > 0    )


select * from rest_with_min_1_order_and_100_monthlysales
-- select month, 100.0 *avg(case when more100 = True then 1 else 0 end)as perc_over_100 from rest_with_min_1_order_and_100_monthlysales

-- group by month
