Write a query to find the weight for each shipment's earliest shipment date. Output the shipment id along with the weight.


select shipment_id, weight from amazon_shipment
where (shipment_id, shipment_date) in
(select shipment_id, min(shipment_date)


from amazon_shipment

group by shipment_id)
