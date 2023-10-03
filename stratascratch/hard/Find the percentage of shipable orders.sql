Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.


with total_orders as(
select 

count(o.id) as x
from orders o),

h2 as(
select count(o.id)as x from orders o inner join customers c on o.cust_id = c.id
where address is not null)

select h2.x /t.x::numeric * 100.0 from total_orders t cross join h2  
