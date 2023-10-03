Find the average total checkouts from Chinatown libraries in 2016.




select 

avg(total_checkouts)

from library_usage
where circulation_active_year = 2016 and home_library_definition = 'Chinatown'
