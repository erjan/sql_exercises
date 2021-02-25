-- Выведите имена всех пар пассажиров, летевших вместе на одном рейсе два 
-- или более раз, и количество таких совместных рейсов.
-- В passengerName1 разместите имя пассажира с наименьшим идентификатором.

select 

case when pas1_id < pas2_id then pas1_name
else pas2_name end as passengerName1, 

case when pas1_id > pas2_id then pas1_name 
else pas2_name end as passengerName2, 
count 

from (select p1pas, pas1_id, count(distinct p1trip) as count, pas1_name, p2pas, pas2_id , pas2_name from (

select 
p1.passenger as p1pas, 
pas1.id as pas1_id,
pas1.name as pas1_name, 

p2.passenger as p2pas, 
pas2.id as pas2_id,
pas2.name as pas2_name,

p1.trip as p1trip, 
p2.trip as p2trip
from 
pass_in_trip p1
inner join pass_in_trip p2 on p1.trip = p2.trip 
inner join Passenger pas1 on p1.passenger = pas1.id 
inner join passenger pas2 on p2.passenger = pas2.id

where p1.passenger < p2.passenger )k
group by p1pas, pas1_id, pas1_name, p2pas, pas2_id , pas2_name
having count(distinct p1trip) >=2)o 
