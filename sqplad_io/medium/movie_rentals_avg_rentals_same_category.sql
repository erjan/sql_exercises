/*
Write a query to return the number of rentals per movie, and the average number of rentals in its same category.
You only need to return results for film_id <= 10.
Return 4 columns: film_id, category name, number of rentals, and the average number of rentals from its category.
*/

WITH num_rentals AS (
	SELECT
	    I.film_id, fc.category_id, count(r.rental_id)
	FROM film_category fc	
	INNER JOIN inventory I
	ON I.film_id = fc.film_id
    
    INNER JOIN rental r
	ON r.inventory_id = I.inventory_id

	GROUP BY I.film_id, fc.category_id
    order by I.film_id 
)


select film_id, c.name as category_name, count as rentals,

avg(count) over(partition by c.name ) as avg_rentals_category


from num_rentals nr
inner join category c on c.category_id = nr.category_id
order by film_id
limit 10


-- official solution

WITH movie_rental AS (
    SELECT
        I.film_id,
        COUNT(*) rentals
    FROM rental R
    INNER JOIN inventory I
    ON I.inventory_id = R.inventory_id
    GROUP BY I.film_id
)
SELECT 
    film_id, 
    category_name, 
    rentals, 
    avg_rentals_category 
FROM (
	SELECT
	    MR.film_id,
	    C.name category_name,
	    rentals,
	    AVG(rentals) OVER(PARTITION BY C.name) avg_rentals_category
	FROM movie_rental MR
	INNER JOIN film_category FC
	  ON FC.film_id = MR.film_id
	INNER JOIN category C
	  ON C.category_id = FC.category_id
) X
WHERE film_id <= 10
;
