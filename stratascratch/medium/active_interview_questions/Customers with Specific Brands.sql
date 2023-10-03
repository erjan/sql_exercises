In the latest promotion, the marketing department wants to target customers who have bought products from two specific brands.
Prepare a list of customers who purchased products from both the "Fort West" and the "Golden" brands.


with h as(
select * from facebook_products fp join facebook_sales fs on fp.product_id = fs.product_id),

h2 as(
select customer_id from h where brand_name = 'Fort West'),
h3 as(
select customer_id from h where brand_name = 'Golden')


select distinct customer_id from h2 where h2.customer_id in (select * from h3)



