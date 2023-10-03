Find the lowest order cost of each customer.
Output the customer id along with the first name and the lowest order price.


select 


c.id, first_name,
min(total_order_cost) as t
from customers c left join orders o on c.id = o.cust_id
group by c.id,first_name

having min(total_order_cost)>0
