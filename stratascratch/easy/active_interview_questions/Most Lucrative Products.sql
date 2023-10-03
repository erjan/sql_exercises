For the 5 most lucrative products, i.e. products that generated the highest revenue, output their IDs and the total revenue.

with h as(
select 

product_id,
sum(cost_in_dollars*units_sold) as x
from facebook_sales 
group by product_id),

h2 as(
select product_id, x, rank()over(order by x desc) as rnk from h)

select * from h2
where rnk<=5
