Check if there is a correlation between average total order value and average time in minutes between placing the order and delivering the order per restaurant.

with h as(

select 
restaurant_id,

avg(extract(epoch from (delivered_to_consumer_datetime-
          customer_placed_order_datetime))/60) as minute_times, 

 avg(order_total) as avg_value


from doordash_delivery 
group by restaurant_id)

select corr(minute_times,avg_value) from h
