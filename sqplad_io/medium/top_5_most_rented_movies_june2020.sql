Write a query to return the film_id and title of the top 5 movies that were rented the most times in June 2020
Use the rental_ts column from the rental for the transaction time.
The order of your results doesn't matter.
If there are ties, return any 5 of them


	select film_id, title from (
select film.film_id, title, count(film.film_id )from inventory inner join film on inventory.film_id = film.film_id
inner join  rental on rental.inventory_id = inventory.inventory_id 
where extract(month from date(rental_ts)) = 6 
and extract(year from date(rental_ts)) = 2020

group by film.film_id, title
order by count desc limit 5)k

    
    
    
    SELECT 
    F.film_id, 
    MAX(F.title) AS title   
FROM rental R
INNER JOIN inventory I
ON I.inventory_id = R.inventory_id
INNER JOIN film F
ON F.film_id = I.film_id
WHERE DATE(rental_ts) >= '2020-06-01'
AND   DATE(rental_ts) <= '2020-06-30'
GROUP BY F.film_id
ORDER BY COUNT(*) DESC
LIMIT 5;
