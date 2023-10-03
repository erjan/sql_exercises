Find customers who have never made an order.
Output the first name of the customer.

select * from customers c where c.id not in (select cust_id from orders)
