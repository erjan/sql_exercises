You’re analyzing a user’s purchases for a retail business.

Each product belongs to a category. Your task is to identify which purchases represent the first time the user has bought a product from its own category and which purchases represent repeat purchases within the product category.

The id in the purchases table represents the purchase order (rows with a lower id are earlier purchases).

Your code should output a table that includes every purchase the user has made. Additionally, the table should include a boolean column with a value of 1 if the user has previously purchased a product from its category and 0 if it’s their first time buying a product from that category.

Note: Sort the results by the time purchased, in ascending order.


with cte1 as(
select id,product_name,product_category,
rank() over(partition by product_category order by id) as ranks
from purchases
)

select product_name,
case when ranks = 1 then 0 else 1 end as category_previously_purchased
from cte1
