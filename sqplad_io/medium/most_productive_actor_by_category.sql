	
  
 /*
  An actor’s productivity is defined as the number of movies he/she has played.
Write a query to return the category_id, actor_id and number of moviesby the most productive actor in that category.
For example: John Doe filmed the most action movies, your query will return John as the result for action movie category.
Do this for every movie category.
*/

WITH h1  AS (
    SELECT    
     fc.category_id,

      a.actor_id,
    
  count(distinct fa.film_id) as num_movies
    
  from actor a inner join film_actor fa on a.actor_id = fa.actor_id
  inner join film_category fc on fc.film_id = fa.film_id
  group by  fc.category_id, a.actor_id
)	  
	  
select category_id, actor_id,

num_movies from (
  
 select category_id, actor_id , num_movies,
  
  row_number() over(partition by category_id order by num_movies desc)as position_index
from h1) k

 where position_index = 1
	
