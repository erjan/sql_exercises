/*
Any customers who made at least 10 movie rentals are happy 
customers, write a query to return the dates when the 
following customers became happy customers:
customer_id in (1,2,3,4,5,6,7,8,9,10).
You can skip a customer if he/she never became a ‘happy customer'. 

здесь надо было не sum, count а просто порядок поставить через роу_намбер() - посчитать их порядковый номер раскиданный по кажд. клиенту-кастомеру и 
*/


with h as (
 
select date(rental_ts) as date,
customer_id,

row_number() over(partition by customer_id order by rental_ts) as num_rentals

from rental
where customer_id in (1,2,3,4,5,6,7,8,9,10)
--order by num_rentals desc
)

select customer_id, date from h

where num_rentals = 10


