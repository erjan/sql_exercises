COMPANY X employees are trying to find the cheapest flights to upcoming conferences. When people fly long distances, a direct city-to-city flight is often more expensive than taking two flights with a stop in a hub city. Travelers might save even more money by breaking the trip into three flights with two stops. But for the purposes of this challenge, let's assume that no one is willing to stop three times! You have a table with individual airport-to-airport flights, which contains the following columns:


• id - the unique ID of the flight;
• origin - the origin city of the current flight;
• destination - the destination city of the current flight;
• cost - the cost of current flight.


Your task is to produce a trips table that lists all the cheapest possible trips that can be done in two or fewer stops. This table should have the columns origin, destination and total_cost (cheapest one). Sort the output table by origin, then by destination. The cities are all represented by an abbreviation composed of three uppercase English letters. Note: A flight from SFO to JFK is considered to be different than a flight from JFK to SFO.


Example of the output:
origin | destination | total_cost
DFW | JFK | 200








with recursive h as(
select origin , destination , cost ,1 as n_connection
from da_flights



union all
select a.origin, b.destination, a.cost + b.cost,
b.n_connection+1
from da_flights a inner join h b on a.destination = b.origin)




select origin, destination, min(cost) from h 
group by origin, destination
order by origin desc, destination

