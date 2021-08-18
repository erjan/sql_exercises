Write a query to return quartiles for the following movies by number of rentals among all movies.
film_id IN (1,10,11,20,21,30).
Use NTILE(4) to create quartile buckets.
The order of your results doesn't matter.
Return the following columns: film_id, number of rentals, quartile.


select film_id, num_rentals, quartile from (

select

film.film_id, 
count(distinct rental.rental_id) as num_rentals,

-- nth_value(4,4) over(order by count(rental.rental_id) ) as quartile


ntile(4) over (order by count(distinct rental.rental_id) ) as quartile

from film

inner join inventory 
on film.film_id = inventory.film_id
inner join rental on rental.inventory_id = inventory.inventory_id
inner join payment on payment.customer_id = rental.customer_id 
and rental.rental_id  = payment.rental_id
-- where film.film_id IN (1,10,11,20,21,30)
group by film.film_id

order by num_rentals)k

where film_id IN (1,10,11,20,21,30)

    
