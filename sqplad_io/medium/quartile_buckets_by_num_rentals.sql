
/*
Write a query to return the quartile by the number of rentals 
for the following customers:
customer_id IN (1,2,3,4,5,6,7,8,9,10)
*/

WITH cust_rentals AS (
    SELECT C.customer_id, 
    MAX(C.store_id) AS store_id, -- one customer can only belong to one store
    COUNT(*) AS num_rentals FROM 
    rental R
    INNER JOIN customer C
    ON C.customer_id = R.customer_id
    GROUP BY C.customer_id
)


select customer_id, store_id, quartile from(

select 
customer_id, store_id, 
ntile(4) over(partition by store_id order by num_rentals ) as quartile
from cust_rentals)k

 where customer_id IN (1,2,3,4,5,6,7,8,9,10)
 order by customer_id desc, store_id
 
 
 -- mistake i made:
 -- calculating over customer 1 to 10 FIRST , the correct solution is to calculate quartile by ALL CUSTOMERS - then select those i need
 
select customer_id, store_id, 
ntile(4) over(partition by store_id order by num_rentals ) as quartile
from cust_rentals
where customer_id IN (1,2,3,4,5,6,7,8,9,10)
 
 
