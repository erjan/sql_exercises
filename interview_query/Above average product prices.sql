Given a table of transactions and products, write a
  query to return the product id, product price, and average transaction 
  total value (price*quantity) of each product with a price greater than the average transaction price.



with temp1 as(
select 
round(avg(price*quantity),1) as avgx

from transactions t left join products p on t.product_id = p.id)


select id as product_id, 

avgx as avg_price, 
id as product_id,
price as product_price

from temp1 t, products p where p.price > t.avgx
-----------------------------------------------------------------------------------------------------------------
WITH zap AS (
    SELECT ROUND(AVG(price * quantity), 2) AS avg_price
    FROM transactions AS t
    INNER JOIN products AS p
    	ON t.product_id = p.id
)
SELECT id AS product_id ,price AS product_price, avg_price FROM products
JOIN zap ON 1 = 1
WHERE price > avg_price
