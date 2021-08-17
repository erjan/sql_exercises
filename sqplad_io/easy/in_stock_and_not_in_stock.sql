
/*
Write a query to return the number of films that we have inventory vs no inventory.
A film can have multiple inventory ids
Each film dvd copy has a unique inventory ids


*/


select 'in stock' as in_stock, count(distinct film.film_id) from film inner join inventory on film.film_id =inventory.film_id
Union
select 'not in stock' as in_stock , count (*) from film where film.film_id not in (select inventory.film_id from inventory)
											
