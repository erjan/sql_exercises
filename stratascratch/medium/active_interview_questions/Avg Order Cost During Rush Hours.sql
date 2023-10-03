Write a query that returns the average order cost per hour during hours 3 PM -6 PM (15-18) in San Jose. For calculating time period use 'Customer placed order datetime' field. Earnings value is 'Order total' field. Order output by hour.


with h as(

select 
*,
extract(hour from customer_placed_order_datetime) as hour

from doordash_delivery

where delivery_region = 'San Jose')


select hour, avg(order_total) avg_earnings 
from h where hour between 15 and 18
group by hour
