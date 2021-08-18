Write a query to return actors who appeared in both tv and movies
The order of your results doesn't matter.
You need to use INNER JOIN.

select actor_movie.* from actor_movie inner join actor_tv using(actor_id)

    
