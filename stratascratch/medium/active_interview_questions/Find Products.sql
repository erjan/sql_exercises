Find product ids whose average sales price is at least $3 and that are sold at least 2 times? Output product id and their brand.

select product_id,  brand_name from facebook_products where product_id in (
select fp.product_id  from facebook_products fp join facebook_sales fs on 
fp.product_id = fs.product_id

group by fp.product_id
having avg(cost_in_dollars)>=3 and count(fs.product_id)>=2)
