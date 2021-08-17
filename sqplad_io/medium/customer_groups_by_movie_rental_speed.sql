/*
Write a query to return the number of customers in 3 separate groups: high, medium, low.
The order of your results doesn't matter.
Definition
high: movie rental spend >= $150.
medium: movie rental spend >= $100, <$150.
low: movie rental spend <$100.
Hint
If a customer spend 0 in movie rentals, he/she belongs to the low group.
*/

    -- my solution
with high as (	

select customer.customer_id, sum(amount) as s from customer right join 

payment on customer.customer_id = payment.customer_id

group by customer.customer_id

having sum(amount) >=150),

medium as ( 
  select customer.customer_id, sum(amount) as s from customer right join 

payment on customer.customer_id = payment.customer_id

group by customer.customer_id

having sum(amount) >=100 and sum(amount) < 150),

low as ( 
  select customer.customer_id, sum(amount) as s from customer right join 

payment on customer.customer_id = payment.customer_id

group by customer.customer_id

having sum(amount) < 100), 

h1 as (select count(customer_id) from high),
  
h2 as (select count(customer_id) from medium ),
      
h3 as (select count(customer_id) from low)

select 'high' as customer_group ,count from h1
union
select 'medium' as customer_group ,count from h2

union
select 'low' as customer_group ,count from h3


-- official solution

SELECT customer_group, COUNT(*) 
FROM (
	SELECT 
		C.customer_id,
	    CASE WHEN SUM(P.amount) >= 150 THEN 'high'
	         WHEN SUM(P.amount) >= 100 THEN 'medium'
	         ELSE 'low' END customer_group
	FROM customer C
	LEFT JOIN payment P
	ON P.customer_id = C.customer_id
	GROUP BY C.customer_id
) X
GROUP BY customer_group
;


