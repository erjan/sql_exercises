For each service, calculate the percentage of incomplete orders along with the revenue loss percentage. Your output should include the name of the service, percentage of incomplete orders, and revenue loss from the incomplete orders.


with h as(
select 

service_name,
sum(monetary_value) as possible_profit,
sum(number_of_orders) as total_orders,
sum(number_of_orders)filter(where status_of_order !='Completed') as lost_orders_num,

sum(monetary_value)filter(where status_of_order ='Completed') as completed,
sum(monetary_value)filter(where status_of_order !='Completed') as lost_profit

from uber_orders

group by service_name)

select service_name, (lost_orders_num/total_orders)*100 as orders_loss_percent,
(lost_profit/possible_profit)*100 as profit_loss_percent
from h
