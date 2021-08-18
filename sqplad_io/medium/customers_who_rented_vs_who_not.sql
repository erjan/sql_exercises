Write a query to return the number of customers who rented at least one movie vs. those who didn't in May 2020.
The order of your results doesn't matter.
Use customer table as the base table for all customers (assuming all customers have signed up before May 2020)
Rented: if a customer rented at least one movie.
Bonus: Develop a LEFT JOIN as well as a RIGHT JOIN solution


select * from rental where date(rental_ts) >= '2020-05-01' and date(rental_ts) <= '2020-05-31'

--official

SELECT have_rented, COUNT(*)
FROM (
	SELECT 
	    C.customer_id,
	    CASE WHEN R.customer_id IS NOT NULL THEN 'rented' ELSE 'never-rented' END AS have_rented
	FROM customer C
	LEFT JOIN (
	    SELECT DISTINCT customer_id
		FROM rental 
	    WHERE DATE(rental_ts) >= '2020-05-01'
	    AND DATE(rental_ts) <= '2020-05-31'
    ) R	
	ON R.customer_id = C.customer_id	
) X
GROUP BY have_rented;
