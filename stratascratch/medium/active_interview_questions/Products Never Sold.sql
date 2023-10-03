The VP of Sales feels that some product categories don't sell and can be completely removed from the inventory. As a first pass analysis, they want you to find what percentage of product categories have never been sold.


SELECT 



(1 - cast(count(distinct fp.product_category)as float)/
count(distinct fc.category_id))*100.0 as rate

FROM facebook_products fp join 
facebook_sales fs on fp.product_id = fs.product_id right join facebook_product_categories
fc on fc.category_id = fp.product_category
