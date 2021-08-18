Write a query to return the name of the customer who spent the second highest for movie rentals in May 2020.
If there are ties, return any one of them.


   
	select first_name, last_name from customer where customer_id in 
	( select c from (
	
	select customer_id as c , sum(amount) s from customer inner join payment using(customer_id)
	where extract( year from date(payment_ts)) = 2020 and extract( month from date(payment_ts)) = 5
	group by customer_id

	order by s desc limit 1 offset 1)k)
  
  
  -- official solution
  
  WITH cust_spend_may AS (
    SELECT customer_id,
	SUM(amount) AS cust_spend
    FROM payment
    WHERE payment_ts >= '2020-05-01'
    AND payment_ts < '2020-06-01'
    GROUP BY customer_id
    ORDER BY cust_spend DESC
    LIMIT 2
)
SELECT 
    first_name, 
    last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM cust_spend_may
    ORDER BY cust_spend
    LIMIT 1
);

    
