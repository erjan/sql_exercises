Find the product with the most orders from users in Germany. Output the market name of the product or products in case of a tie.


select market_name from (
select 

count(so.order_id), rank()over(order by count(so.order_id) desc) as rnk,
market_name

from shopify_orders so left join shopify_users su on so.user_id = su.id
join map_product_order mp on mp.order_id = so.order_id join

dim_product d on d.prod_sku_id = mp.product_id

where su.country = 'Germany'

group by market_name) k where rnk = 1
