Write a query to return the total number of actors using UNION.
Actor who appeared in both tv and movie has the same value of actor_id in both actor_tv and actor_movie tables.



	select count(*) from (
	select actor_id from actor_movie 
	
	union 
	
	select actor_id from actor_tv )k
