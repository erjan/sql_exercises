
/*
Write a query to return the percentage of revenue for each of the following films: film_id <= 10 by its category.
Formula: revenue (film_id x) * 100.0/ revenue of all movies in the same category.
The order of your results doesn't matter.
Return 3 columns: film_id, category name, and percentage.
*/


--my solution

   WITH movie_revenue AS (
	SELECT 
	    I.film_id, c.name as category_name, SUM(P.amount) revenue
	FROM payment P
	INNER JOIN rental R
	ON R.rental_id = P.rental_id
	INNER JOIN inventory I
	ON I.inventory_id = R.inventory_id
	
	inner join film on film.film_id = I.film_id
	 inner join film_category fc on fc.film_id = film.film_id
	 inner join category c on c.category_id = fc.category_id
	 
	 
	GROUP BY I.film_id, c.name
)
SELECT film_id, category_name, revenue * 100.0 / SUM(revenue) OVER(partition by category_name) revenue_percentage
FROM movie_revenue
ORDER BY film_id
LIMIT 10
;


-- official solution

WITH movie_revenue AS (
	SELECT
	    I.film_id, SUM(P.amount) revenue
	FROM payment P
	INNER JOIN rental R
	ON R.rental_id = P.rental_id
	INNER JOIN inventory I
	ON I.inventory_id = R.inventory_id	
	GROUP BY I.film_id
)
SELECT 
    MR.film_id, 
    C.name category_name,
    revenue * 100.0 / SUM(revenue) OVER(PARTITION BY C.name) revenue_percent_category
FROM movie_revenue MR
INNER JOIN film_category FC
  ON FC.film_id = MR.film_id
INNER JOIN category C
  ON C.category_id = FC.category_id
ORDER BY film_id
LIMIT 10
;
