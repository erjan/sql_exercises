/*
For movies that are not in demand (rentals = 0 in May 2020), we want to remove them from our inventory.
Write a query to return the number of unique inventory_id from those movies with 0 demand.
Hint: a movie can have multiple inventory_id.
*/



-- official solution - i did not solve it
SELECT COUNT(inventory_id )
FROM inventory I
INNER JOIN (
	SELECT F.film_id
	FROM film F
	LEFT JOIN (
	    SELECT DISTINCT I.film_id
	    FROM inventory I
	    INNER JOIN (
		SELECT inventory_id, rental_id
		FROM rental 
		WHERE DATE(rental_ts) >= '2020-05-01'
		AND DATE(rental_ts) <= '2020-05-31'
	    ) R
	    ON I.inventory_id = R.inventory_id
	) X ON X.film_id = F.film_id
	WHERE X.film_id IS NULL
)Y
ON Y.film_id = I.film_id;
