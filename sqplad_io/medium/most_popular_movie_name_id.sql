Write a query to return the name of the most popular film category and its category id
If there are ties, return just one of them.



	select c, name from (
	
	select category.category_id as c , name, count(film_category.film_id) from film_category inner join
	category on category.category_id = film_category.category_id
	group by category.category_id, name
	order by  count desc limit 1)k

    --official
    
    SELECT 
    C.category_id,
    MAX(C.name) AS name
FROM film_category FC
INNER JOIN category C
ON C.category_id = FC.category_id
GROUP BY C.category_id
ORDER BY COUNT(*) DESC
LIMIT 1;
