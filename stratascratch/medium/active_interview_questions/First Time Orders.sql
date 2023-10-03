For each merchant, find how many orders and first-time orders they had. First-time orders are meant from the perspective of a customer and are the first order that a customer ever made. In order words, for how many customers was this the first-ever merchant they ordered with?
Output the name of the merchant, the total number of their orders and the number of these orders that were first-time orders.


with first_order as(
select 

customer_id,
first_value(merchant_id)over(partition by customer_id order by order_timestamp) as first_merchant

from doordash_orders),

num_customers as(
select merchant_id, count(distinct f.customer_id) as first_time_orders,
count(distinct id) as total_num_orders from doordash_orders d left join first_order f on d.merchant_id = f.first_merchant
group by merchant_id
)

select name, total_num_orders, first_time_orders from num_customers n join doordash_merchants d on n.merchant_id = d.id



