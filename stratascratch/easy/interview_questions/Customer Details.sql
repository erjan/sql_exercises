Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items. Sort records based on the customer's first name and the order details in ascending order.

select 

first_name, last_name,city, order_details

from customers c left join orders o on o.cust_id = c.id

order by first_name, order_details 
