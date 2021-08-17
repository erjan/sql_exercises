/*
Write a query to return the shortest movie from each category.
The order of your results doesn't matter.
If there are ties, return just one of them.
Return the following columns: film_id, title, length, category, row_num
*/


-- my solution
select film_id, title, length, category, row_num from (

select f.film_id,title,f.length, c.name as category,


row_number() over(partition by c.name order by f.length  )  as row_num



from film f inner join film_category on f.film_id = film_category.film_id
inner join category c on c.category_id = film_category.category_id)k

where k.row_num = 1


-- solution 1 official

WITH movie_ranking AS (
  SELECT  
    F.film_id,
    F.title, 
    F.length, 
    C.name category,
    ROW_NUMBER() OVER(PARTITION BY C.name ORDER BY F.length) row_num    
  FROM film F
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
) 

SELECT 
  film_id,
  title,
  length,
  category,
  row_num
FROM movie_ranking
WHERE row_num = 1
;
-- solution 2 official

SELECT 
  film_id,
  title,
  length,
  category,
  row_num
FROM (
  SELECT  
    F.film_id,
    F.title, 
    F.length, 
    C.name category,
    ROW_NUMBER() OVER(PARTITION BY C.name ORDER BY F.length) row_num    
  FROM film F
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
) X
WHERE row_num = 1
;
