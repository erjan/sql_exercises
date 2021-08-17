	
  
/*
Write a query to return the total number of sales for each product this month (August 2021).
number of sales = sum(qty per order) .
ordering of your results is not considered.
*/


with h1 as (

select
order_id,product_id,
sum(qty) as x from orders group by order_id, product_id)


select product_id, sum(x) from h1 group by product_id


-- official solution

SELECT product_id, SUM(qty)
FROM orders
WHERE order_dt >= '2021-08-01'
AND order_dt < '2021-09-01'
GROUP BY product_id;
