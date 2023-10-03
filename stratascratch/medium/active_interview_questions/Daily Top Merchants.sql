For each day, find the top 3 merchants with the highest number of orders on that day. In case of a tie, multiple merchants can share the same place but on each day, there should always be at least 1 merchant on the first, second and third place.
Output the date, the name of the merchant and their place in the daily ranking.


with h as(
select  merchant_id,cast(order_timestamp as date)as order_day,
dense_rank()over(partition by cast(order_timestamp as date) order by count(customer_id) desc) ranking


from doordash_orders group by order_day, merchant_id)


select order_day, name, ranking from h join doordash_merchants d on d.id = h.merchant_id where ranking < 4 order by order_day, ranking

