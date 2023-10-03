Write a query that returns average earnings per order segmented by weekday and hour. For calculating the time period use 'Customer placed order datetime' field. Earnings value is 'Order total' field.


Note: Our questions mimic real-life scenarios, where you would be working with different timezones, hence any day_of_week function works, but for the sake of having your answer accepted, consider the day_of_week function that marks Monday as 1 and Sunday as 7


with h as(
select 

order_total,
extract(isodow from customer_placed_order_datetime)as weekday,
extract(hour from customer_placed_order_datetime) as hour
from doordash_delivery)


select weekday, hour, avg(order_total)  as avg_earnings 
from h

group by weekday, hour

