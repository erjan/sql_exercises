Find the number of customers without an order.




select 

count(c.id)
from customers c where c.id not in (select cust_id from orders)
