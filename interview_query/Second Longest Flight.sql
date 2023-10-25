'''
Given a table of flights, extract the 2nd flight with the most duration between each pair of cities. Order the flights by the flight id ascending.

Note: For any cities X and Y, (source_location=X, destination_location=Y) and (source_location=Y, destination_location=X) are counted as the same pair of cities.

Note: If there are fewer than two flights between two cities, there is no 2nd longest flight.
'''


with cte1 as(


select id, destination_location as x, source_location as y,'1' as helper,flight_end,flight_start, 

timestampdiff(second, flight_start, flight_end)as diff
from flights

union all

select id, source_location as x, destination_location as y,'2' as helper,flight_end,flight_start,
timestampdiff(second, flight_start, flight_end)as diff
from flights
),

cte2 as(select *, row_number()over(partition by x,y order by diff desc) as ranking from cte1)
select id, x as destination_location, y as source_location , flight_start,flight_end
from cte2 where ranking = 2 and helper = '1'
order by id asc


