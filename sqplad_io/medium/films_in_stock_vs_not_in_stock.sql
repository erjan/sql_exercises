Write a query to return the number of films that we have inventory vs no inventory.
A film can have multiple inventory ids
Each film dvd copy has a unique inventory ids

select 'in stock' as in_stock, count(distinct film.film_id) from film inner join inventory on film.film_id =inventory.film_id
Union
select 'not in stock' as in_stock , count (*) from film where film.film_id not in (select inventory.film_id from inventory)

    --official
    
    SELECT in_stock, COUNT(*) 
FROM (
	SELECT 
		F.film_id, 
		MAX(CASE WHEN I.inventory_id IS NULL THEN 'not in stock' ELSE 'in stock' END) in_stock
	FROM film F
	LEFT JOIN INVENTORY I
	ON F.film_id =I.film_id
	GROUP BY F.film_id
) X
GROUP BY in_stock;
