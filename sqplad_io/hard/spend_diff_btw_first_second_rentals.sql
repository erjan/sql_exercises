   
   /*
   Write a query to return the difference of the spend amount between the following customers' first movie rental and their second rental.
customer_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10).
Use first spend - second spend to compute the difference.
Skip users who only rented once.
*/
   
   
	
	
with help as (	

select customer_id, payment_ts, amount,

row_number() over(partition by customer_id order by payment_ts desc) as r

from payment where customer_id IN (1,2,3,4,5,6,7,8,9,10) ),



h2 as (
  select * from help where r <=2
  ),

h3 as (

select customer_id,

amount - lag(amount,1)over(partition by customer_id order by r desc)

as delta

from h2 )

select * from h3 where delta is not null

-- official solution



WITH cust_spend_seq AS (
	SELECT 
	  customer_id,
	  payment_ts,
	  amount AS current_payment,
	  LAG(amount, 1) OVER(PARTITION BY customer_id ORDER BY payment_ts) AS prev_payment,
	  ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY payment_ts DESC) AS payment_idx
	FROM payment P
)
SELECT
    customer_id,
    current_payment - prev_payment AS delta
FROM cust_spend_seq
WHERE customer_id IN(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
AND payment_idx = 1;
