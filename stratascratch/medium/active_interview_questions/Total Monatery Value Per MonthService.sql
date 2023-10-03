Find the total monetary value for completed orders by service type for every month. Output your result as a pivot table where there is a column for month and columns for each service type.





select extract(month from order_date) as month,

sum(monetary_value)filter(where service_name ='Uber_BOX') as Uber_box,
sum(monetary_value)filter(where service_name ='Uber_CLEAN') as Uber_CLEAN,
sum(monetary_value)filter(where service_name ='Uber_BOX') as Uber_box,
sum(monetary_value)filter(where service_name ='Uber_FOOD') as Uber_FOOD,
sum(monetary_value)filter(where service_name ='Uber_GLAM') as Uber_GLAM,
sum(monetary_value)filter(where service_name ='Uber_KILAT') as Uber_KILAT,
sum(monetary_value)filter(where service_name ='Uber_MART') as Uber_MART,
sum(monetary_value)filter(where service_name ='Uber_MASSAGE') as Uber_MASSAGE,
sum(monetary_value)filter(where service_name ='Uber_RIDE') as Uber_RIDE,
sum(monetary_value)filter(where service_name ='Uber_SEND') as Uber_SEND,
sum(monetary_value)filter(where service_name ='Uber_SHOP') as Uber_SHOP,
sum(monetary_value)filter(where service_name ='Uber_TIX') as Uber_TIX




from uber_orders

where status_of_order = 'Completed' group by month



