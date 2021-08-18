Write a query to return the total number of customers who didn't rent any movies in May 2020.
Hint
You can use NOT IN to exclude customers who have rented movies in May 2020.


 
 select count(distinct customer.customer_id) from customer where customer.customer_id not in 
 (select rental.customer_id from rental
 where extract(year from date(rental_ts)) = 2020 and 
 extract(month from date(rental_ts)) = 5 )

    
