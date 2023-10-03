Find customers who appear in the orders table more than three times.



select 
cust_id,
count(id)
from orders
group by cust_id
having count(*)>3
