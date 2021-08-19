Write a query to return the number of films with no rentals in Feb 2020.
Count the entire movie catalog from the film table.

-- my solution

select count(film.film_id) from film where film.film_id not in (

    select film.film_id from film inner join inventory on film.film_id = inventory.film_id 
	inner join rental on rental.inventory_id = inventory.inventory_id 
	
	where extract( month from date(rental_ts)) = 2 and extract(year from date(rental_ts)) = 2020)

    -- official solution
    
    WITH rented_film AS (
	SELECT DISTINCT film_id 
	FROM inventory 
	WHERE inventory_id IN(
		SELECT inventory_id
		FROM rental
		WHERE DATE(rental_ts) >= '2020-02-01'
		AND   DATE(rental_ts) <= '2020-02-29'
	)
)

SELECT COUNT(*)
FROM film
WHERE film_id NOT IN(
    SELECT film_id
    FROM rented_film
);
