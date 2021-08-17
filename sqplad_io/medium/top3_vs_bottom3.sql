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
