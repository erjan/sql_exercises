Write a query to return revenue percentiles (ordered ascendingly) of the following movies within their category:
film_id IN (1,2,3,4,5).


WITH movie_rev_by_cat AS (
    SELECT 
       F.film_id,
       MAX(FC.category_id) AS category_id,
       SUM(P.amount) AS revenue
    FROM film F
    INNER JOIN inventory I
    ON I.film_id = F.film_id
    INNER JOIN rental R
    ON R.inventory_id = I.inventory_id
    INNER JOIN payment P
    ON P.rental_id = R.rental_id
    INNER JOIN film_category FC
    ON FC.film_id = F.film_id
    GROUP BY F.film_id
),



help as (


select film_id , revenue, category_id from movie_rev_by_cat ) ,


help2 as (
select film_id, revenue, category_id, ntile(100) over( partition by category_id order by revenue) as perc_by_cat 

from help order by film_id)


select film_id, perc_by_cat from help2 where film_id IN (1,2,3,4,5)

    
