Write a query to return the names of the top 5 cities with the most rental revenues in 2020.
Include each city's revenue in the second column.
The order of your results doesn't matter.
If there are ties, return any one of them.
Yours results should have exactly 5 rows.


  
  select city.city, sum(amount) as sum  from city 
  inner join address on city.city_id = address.city_id
  inner join customer on customer.address_id = address.address_id
  inner join payment on payment.customer_id = customer.customer_id
  where extract( year from payment_ts) = 2020
  group by city.city
  order by sum desc limit 5

    
