Write a query to return the film category id with the most films, as well as the number films in that category.


  
  with helper as (
  
  select category_id, 
	count(film_id) as film_cnt 
	from film_category group by category_id  order by film_cnt desc limit 1)
	
	
select category_id, film_cnt from helper

    
