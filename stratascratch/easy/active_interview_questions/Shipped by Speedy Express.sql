How many orders were shipped by Speedy Express in total?




select 
count(order_id)

from shopify_orders so join shopify_carriers sc on so.carrier_id = sc.id

where sc.name = 'Speedy Express'
