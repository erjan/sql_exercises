Find neighborhoods where you can sleep on a real bed in a villa with internet while paying the lowest price possible.




select neighbourhood, min(price) as p from airbnb_search_details

where property_type = 'Villa' and amenities ilike '%Wireless Internet%'
and bed_type = 'Real Bed' 
group by neighbourhood

order by p asc limit 1
