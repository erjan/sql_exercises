Find the number of apartments per nationality that are owned by people under 30 years old.
Output the nationality along with the number of apartments.
Sort records by the apartments count in descending order.





select 

nationality,
 unit_id, age
from airbnb_hosts ah join airbnb_units au on ah.host_id = au.host_id
where age <30 and unit_type = 'Apartment'
