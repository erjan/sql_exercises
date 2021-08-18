Write a query to return the first and last name of the customer who spent the most on movie rentals in Feb 2020.


  
    select first_name, last_name from payment inner join customer on payment.customer_id = customer.customer_id
	
	where extract(year from payment_ts) = 2020  and extract(month from payment_ts) = 2
	order by amount desc limit 1;

    
