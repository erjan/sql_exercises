	/*
  Write a query to generate percentile distribution for the following movies by their total rental revenue in their category.
film_id <= 20.
Use NTILE(100) to create percentile.
The order of your results doesn't matter.
Return the following columns: category, film_id, revenue, percentile

сделал ошибку - джойнил по customer id а там вобще не надо это!

with total_revenue_per_movie as (
select  f.film_id, max(c.name) as category,
  sum(p.amount) as revenue
from film f inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
inner join payment p on p.customer_id = r.customer_id -- HERE!!!!!!!!!!!!!!!
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
group by f.film_id
)

*/


with total_revenue_per_movie as (

select  
  f.film_id, max(c.name) as category,
  
  sum(p.amount) as revenue  
    
  FROM payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id  
  INNER JOIN film F
  ON F.film_id = I.film_id
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
  GROUP BY F.film_id)

select category, film_id, revenue, percentile from (
select category, film_id,
revenue,
ntile(100) over( partition by category order by revenue ) as percentile
from total_revenue_per_movie)k
where film_id <=20
order by category,revenue


--official solution

WITH film_revenue_by_cat AS (
  SELECT  
    F.film_id,    
    MAX(C.name) AS category,
    SUM(P.amount) revenue
  FROM payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id  
  INNER JOIN film F
  ON F.film_id = I.film_id
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
  GROUP BY F.film_id
)

SELECT 
    category, 
    film_id,
    revenue,
    percentile
FROM (
  SELECT  
    category,
    FR.film_id,
    revenue,    
    NTILE(100) OVER(PARTITION BY category ORDER BY revenue) percentile    
  FROM film_revenue_by_cat FR
  INNER JOIN film_category FC
  ON FC.film_id = FR.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
) X
WHERE film_id <=20
ORDER BY category, revenue;
