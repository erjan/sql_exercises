A group of travelers embark on world tours starting with their home cities. Each traveler has an undecided itinerary that evolves over the course of the tour. Some travelers decide to abruptly end their journey mid-travel and live in their last destination.
Given the dataset of dates on which they travelled between different pairs of cities, can you find out how many travellers ended back in their home city? For simplicity, you can assume that each traveler made at most one trip between two cities in a day.




with h as(
select 
traveler,
min(date) as firstdate , max(date) as lastdate

from travel_history
group by traveler),

start_cities as(

select t.traveler , start_city from travel_history t join h on
h.traveler = t.traveler and h.firstdate = t.date

),
end_cities as(
select t.traveler , end_city from travel_history t join h on 
h.traveler = t.traveler and h.lastdate = t.date
)

select count(*) from end_cities e join 
start_cities s on s.traveler=e.traveler
where start_city = end_city



