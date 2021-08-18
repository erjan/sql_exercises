Write a query to return the first and last name of the customer who made the most rental transactions in May 2020.



 select first_name, last_name from customer where customer_id in 
 	( select c from (
	
	select customer_id as c , count(rental_id) s from customer inner join rental using(customer_id)
	where extract( year from date(rental_ts)) = 2020 and extract( month from date(rental_ts)) = 5
	group by customer_id
	order by s desc   limit 1 )k)
	
