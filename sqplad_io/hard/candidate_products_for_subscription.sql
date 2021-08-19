 /*
 We want to expand our subscription business and make it easy for our 
 customers to have certain products delivered on a regular basis instead of having to reorder them every time.
Products that are purchased multiple times by the same 
customers during this month can be considered as weekly or bi-weekly products for subscription.
Find top 10 products that are purchased by the same customers this month (August 2021) and report their id.
Rank those products based on the number of unique customers.
*/
 
 
 SELECT product_id FROM (
	SELECT product_id, customer_id
	FROM orders
	WHERE order_dt >= '2021-08-01'
	AND order_dt < '2021-09-01'
	GROUP BY product_id, customer_id
	HAVING COUNT(*) >= 2 
	)X 
GROUP BY product_id
ORDER BY COUNT(DISTINCT customer_id) DESC
LIMIT 10;
