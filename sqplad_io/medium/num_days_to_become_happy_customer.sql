/*
Any customers who made 10 movie rentals are happy customers
Write a query to return the average number of days for a customer to make his/her 10th rental.
If a customer has never become a ‘happy’ customer, you should skip this customer when computing the average.
You can use EXTRACT(DAYS FROM tenth_rental_ts - first_rental_ts) to get the number of days in between the 1st rental and 10th rental
Use ROUND(average_days) to return an integer

i started thinking the wrong way - looking for ids of customers who made more than 10 rentals:
with only_happy as (	
	
select customer_id 
from rental
group by customer_id
having count(rental_id) >= 10)

потом хотел юзать lead() - там типо выбрать по порядку 1 и 10 с помощью lead(1), lead(10) - но это неправ.подход
хорошо что посмотрел сразу не стал терять время.

select customer_id, date(rental_ts),rental_ts,

LEAD(rental_ts, 2) OVER (ORDER BY rental_ts ) AS second_rental


from rental
order by customer_id, rental_ts
*/


with numbered_dates as (

select customer_id, rental_ts,

row_number() over(partition by customer_id order by rental_ts) as rental_idx

from rental)



select round(avg(diff)) from (

select customer_id, first_rental_ts, tenth_rental_ts,
extract(days from tenth_rental_ts - first_rental_ts) as diff
from (

SELECT 
        customer_id, 
	    MAX(CASE WHEN rental_idx = 1 THEN rental_ts ELSE NULL END) AS first_rental_ts,
	    MAX(CASE WHEN rental_idx = 10 THEN rental_ts ELSE NULL END) AS tenth_rental_ts
	 FROM numbered_dates
	 GROUP BY customer_id)x
	
	
   WHERE tenth_rental_ts IS not NULL
)o
