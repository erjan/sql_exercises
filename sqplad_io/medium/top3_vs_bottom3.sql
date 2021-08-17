/*
Write a query to return the top 3 and bottom 3 products this month ranked by sales.
sales = sum(unit_price_usd * qty) .
ordering of your results is not considered
Hint
Make sure you clarify with the interviewer on how to deal with ties
*/



with bottom as (	
select product_id,
sum(unit_price_usd*qty) as sales from orders 

group by product_id
order by sales asc limit 3),


top as(
select product_id,
sum(unit_price_usd*qty) as sales from orders 

group by product_id
order by sales desc limit 3)


select product_id,'bottom' as category from bottom
union
select product_id,'top' as category from top



-- official solution

WITH top AS(
	SELECT product_id, SUM(unit_price_usd * qty)
	FROM orders
        WHERE order_dt >= '2021-08-01'
        AND order_dt < '2021-09-01'
	GROUP BY product_id
	ORDER BY SUM(unit_price_usd * qty) DESC 
	LIMIT 3
), 
bottom AS (
	SELECT product_id, SUM(unit_price_usd * qty)
	FROM orders
        WHERE order_dt >= '2021-08-01'
        AND order_dt < '2021-09-01'
	GROUP BY product_id
	ORDER BY SUM(unit_price_usd * qty) 
	LIMIT 3
)
SELECT top.product_id, 'top' 
FROM top
UNION ALL
SELECT bottom.product_id, 'bottom'
FROM bottom;
