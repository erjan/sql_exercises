/*
Write a query to return the cumulative daily rentals for the following customers:
customer_id in (3, 4, 5).
Each day a user had a rental, return their total spent until that day.
If there is no rental on that day, ignore that day.

*/

 with helper as (

 select  date(rental_ts) as date , 
 customer_id, count(rental_id) as  daily_rental from rental where customer_id in (3,4,5)
 
 group by customer_id, date)
 
 select date, customer_id, daily_rental, 
 
 sum(daily_rental)over(partition by customer_id order by date) as cumulative_rentals
 
 from helper
 
