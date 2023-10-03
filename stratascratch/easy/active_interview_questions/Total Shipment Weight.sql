Calculate the total weight for each shipment and add it as a new column. Your output needs to have all the existing rows and columns in addition to the  new column that shows the total weight for each shipment. One shipment can have multiple rows.


with h as(

select 
shipment_id, sum(weight) as total_weight
from amazon_shipment group by shipment_id)

select *, h.total_weight from amazon_shipment a1 join h 
on  h.shipment_id = a1.shipment_id
