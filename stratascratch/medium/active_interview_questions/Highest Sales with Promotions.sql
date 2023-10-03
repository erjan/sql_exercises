Which products had the highest sales (in terms of units sold) in each promotion? Output promotion id, product id with highest sales and highest sales itself.


with h as(
select  

promotion_id, product_id, sum(units_sold)as total
from facebook_sales


group by promotion_id, product_id)



select promotion_id, product_id, total from h a where total = (select max(total) from h b where a.promotion_id = b.promotion_id)
