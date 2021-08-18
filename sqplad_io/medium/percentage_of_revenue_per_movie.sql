	
/*
Write a query to return the percentage of revenue for each of the following films: film_id <= 10.
Formula: revenue (film_id x) * 100.0/ revenue of all movies.
The order of your results doesn't matter.
*/

with reven10 as (


select i.film_id, sum(amount) as revenue from inventory i join rental r on i.inventory_id = r.inventory_id
join payment p on p.rental_id = r.rental_id
 where i.film_id <=10
group by i.film_id
),

   reven as (

select i.film_id, sum(amount) as revenue from inventory i join rental r on i.inventory_id = r.inventory_id
join payment p on p.rental_id = r.rental_id
group by i.film_id

),
total_reven as (

select sum(revenue) as r from reven
)




 select film_id , revenue * 100.0/ (select r from total_reven)
   from reven10 
   
   
   
   --official solution
   
   
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
SELECT film_id, revenue * 100.0 / SUM(revenue) OVER() revenue_percentage
FROM movie_revenue
ORDER BY film_id
LIMIT 10
;
