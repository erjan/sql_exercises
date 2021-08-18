Write a query to return the titles of the films with >= 10 actors.


	
	select  title from film_actor inner join film on film.film_id = film_actor.film_id
	group by title
	having count(actor_id) >=10

    
