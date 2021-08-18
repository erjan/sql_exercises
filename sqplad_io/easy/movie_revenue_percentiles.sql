Write a query to return percentile distribution for the following movies by their total rental revenues in the entire movie catalog.
film_id IN (1,10,11,20,21,30).
A film can only belong to one category.
The order of your results doesn't matter.
Return the following columns: film_id, revenue, percentile


with help as (

select f.film_id , sum(p.amount) as revenue,

ntile(100) over(order by sum(p.amount) ) as percentile

from payment p inner join rental r on r.rental_id = p.rental_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
group by f.film_id)

select * from help where help.film_id in (1,10,11,20,21,30)
