Find "favorite" customers based on the order count and the total cost of orders.
A customer is considered as a favorite if he or she has placed more than 3 orders and with the total cost of orders more than $100.


Output the customer's first name, city, number of orders, and total cost of orders.


with h as(
select 

o.cust_id as id,
count(o.id) as order_cnt,
sum(total_order_cost)as total_cost
from customers c inner join orders o on c.id = o.cust_id
group by o.cust_id
having count(o.id)>3 and sum(total_order_cost)>100
order by total_cost desc)


select h.id ,c.first_name, c.city, order_cnt, total_cost from h  inner join customers c on c.id = h.id
