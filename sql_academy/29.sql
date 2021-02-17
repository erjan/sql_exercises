
-- Выведите имена пассажиров улетевших в Москву (Moscow) на самолете TU-134


select distinct name
from Passenger inner join Pass_in_trip on Pass_in_trip.passenger = Passenger.id inner join trip on trip.id = Pass_in_trip.trip 
where trip.plane = 'TU-134' and town_to ='Moscow' 
order by name desc
