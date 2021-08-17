/*
Write a query to return the number of customers who rented at least one movie in both May 2020 and June 2020.

*/

with may_customer as (


select distinct customer_id from rental where date(rental_ts) >='2020-05-01'
  and date(rental_ts) <='2020-05-31'
)


select count(distinct customer_id) from rental 


where date(rental_ts) >='2020-06-01'
  and date(rental_ts) <='2020-06-30'
  and customer_id in (select customer_id from may_customer)
  
