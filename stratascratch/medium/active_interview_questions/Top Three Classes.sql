The marketing department wants to launch a new promotion for the most successful product classes. What are the top 3 product classes by number of sales?




with h as(
select product_class, count(fc.product_id) as x,

dense_rank()over(order by count(fc.product_id) desc) as rnk

from facebook_products fp join facebook_sales 
fc on fp.product_id = fc.product_id

group by product_class)

select product_class from h where rnk <=3
