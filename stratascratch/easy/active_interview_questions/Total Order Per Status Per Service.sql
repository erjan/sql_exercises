
Uber is interested in identifying gaps in their business. Calculate the count of orders for each status of each service. Your output should include the service name, status of the order, and the number of orders.

select 

status_of_order, service_name,
sum(number_of_orders)
from uber_orders

group by status_of_order, service_name
