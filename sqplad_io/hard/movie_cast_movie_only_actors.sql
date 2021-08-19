/*
Write a query to return the film_id with movie only casts (actors who never appeared in tv).
The order of your results doesn't matter.
You should exclude movies with one or more tv actors

 i did not solve it...((((
*/

select f.film_id from film f left join
(select distinct film_actor.film_id 
 from film_actor 
 inner join actor_tv on 
 actor_tv.actor_id = film_actor.actor_id
)x
 on f.film_id = x.film_id
 
 where x.film_id is null



