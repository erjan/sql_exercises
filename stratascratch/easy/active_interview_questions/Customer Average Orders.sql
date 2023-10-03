How many customers placed an order and what is the average order amount?





select

count(distinct customer_id),
avg(amount)
from postmates_orders

