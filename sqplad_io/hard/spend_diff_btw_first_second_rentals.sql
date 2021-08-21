   
   /*
   Write a query to return the difference of the spend amount between the following customers' first movie rental and their second rental.
customer_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10).
Use first spend - second spend to compute the difference.
Skip users who only rented once.
*/
   
   
	with help as (
	
select customer_id,payment_ts,amount,
row_number()over(partition by customer_id order by payment_ts) as row_num

from payment),


h2 as (

select customer_id, amount, payment_ts, row_num from help

where row_num <=2 and  customer_id in (1,2,3,4,5,6,7,8,9,10) ),

h3 as (

select customer_id, amount - lead(amount) over(partition by customer_id order by row_num) as delta
from h2)


select customer_id, delta from h3 where delta is not null


-- official solution
