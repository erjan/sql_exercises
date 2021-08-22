/*
Write a query to return a customer's life time value for the following: customer_id IN (1, 100, 101, 200, 201, 300, 301, 400, 401, 500).
Add a column to compute the average LTV of all customers from the same store.
Return 4 columns: customer_id, store_id, customer total spend, average customer spend from the same store.
The order of your results doesn't matter.
*/

-- my solution - my mistake that i use where too early, first better to calculate all sums then apply where in the very end! I did not solve it myself!


with help as (
select 
  customer.customer_id, max(store_id) as store_id, 
  sum(amount) as ltd_spend 
  
 from customer inner join payment on customer.customer_id = payment.customer_id

group by customer.customer_id
order by customer.customer_id)

select customer_id, store_id, ltd_spend,store_avg from (

select customer_id, store_id, ltd_spend, 

	    AVG(ltd_spend) OVER(PARTITION BY store_id) as store_avg

from help)x
where customer_id IN (1, 100, 101, 200, 201, 300, 301, 400, 401, 500) 

-- official solution

WITH customer_ltd_spend AS (
	SELECT 
	    P.customer_id, 
	    MAX(store_id) store_id, 
	    SUM(P.amount) ltd_spend
	FROM payment P
	INNER JOIN customer C
	ON C.customer_id = P.customer_id
	GROUP BY P.customer_id
)

SELECT customer_id, store_id, ltd_spend, store_avg 
FROM (
	SELECT
	    customer_id,
	    store_id,
	    ltd_spend,
	    AVG(ltd_spend) OVER(PARTITION BY store_id) as store_avg
	FROM customer_ltd_spend CLS
) X
WHERE X.customer_id IN (1,100,101, 200, 201, 300,301, 400, 401, 500)
ORDER BY 1;
