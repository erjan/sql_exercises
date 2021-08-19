

Write a query to return top 2 films based on their rental revenues in their category.
A film can only belong to one category.
The order of your results doesn't matter.
If there are ties, return just one of them.
Return the following columns: category, film_id, revenue, row_num

with h1 as (

select f.film_id, max(c.name ) as category, sum(amount)as revenue from

payment p inner join  rental r  on p.rental_id = r.rental_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film_category fc on fc.film_id = i.film_id
inner join film f  on f.film_id = fc.film_id
inner join category c on c.category_id = fc.category_id
group by f.film_id),

 -- i solved it myself! - my own solution!
 
 
h2 as (

select  film_id, category, revenue,

dense_rank() over(partition by category order by revenue desc) as rank
from h1)


select category, film_id, revenue, rank from h2
where rank <=2


-- official solution

WITH film_revenue AS (
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

SELECT * FROM (
  SELECT  
    category,
    FR.film_id,
    revenue,    
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY revenue DESC) row_num    
  FROM film_revenue FR
  INNER JOIN film_category FC
  ON FC.film_id = FR.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
) X
WHERE row_num <= 2;
