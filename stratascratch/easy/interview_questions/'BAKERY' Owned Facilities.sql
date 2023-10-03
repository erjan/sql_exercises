Find the owner_name and the pe_description of facilities owned by 'BAKERY' where low-risk cases have been reported.

select distinct owner_name,pe_description  from los_angeles_restaurant_health_inspections

where owner_name ilike '%BAKERY%' and pe_description ilike '%LOW%'
