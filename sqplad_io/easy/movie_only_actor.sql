Write a query to return the first name and last name of actors who only appeared in movies.
Actor appeared in tv should not be included .
The order of your results doesn't matter.


	
select first_name, last_name
from actor_movie --  left join actor_tv using(actor_id)
where actor_movie.actor_id not in (select actor_tv.actor_id from actor_tv)

    
