Find library types with the highest total checkouts in April made by patrons who had registered in 2015 and whose age was between 65 and 74 years.
Output the year patron registered and the home library definition along with the corresponding highest total checkouts. Sort records based on the highest total checkouts in descending order.


select 
year_patron_registered,
home_library_definition, max(total_checkouts) as total_checkout

from library_usage
where year_patron_registered = 2015  and age_range = '65 to 74 years'

and circulation_active_month = 'April'

group by home_library_definition,year_patron_registered
