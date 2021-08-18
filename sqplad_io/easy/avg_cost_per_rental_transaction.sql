Write a query to return the average cost on movie rentals in May 2020 per transaction.


	 
	 select avg(amount) as avg from payment 
	 where extract(month from payment_ts) = 5 and  extract(year from payment_ts) = 2020

    
