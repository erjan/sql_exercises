Find months with the highest number of checkouts for main libraries in 2013.
Output the circulation active month along with the corresponding total monthly checkouts.
Order results based on total monthly checkouts in descending order.



select 
circulation_active_month,
sum(total_checkouts)

from library_usage
where home_library_definition = 'Main Library' and circulation_active_year = 2013

group by circulation_active_month
