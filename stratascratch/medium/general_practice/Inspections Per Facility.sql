Find the average number of inspections per facility across all corporations.
Output the result along with the corresponding owner_name, total number of inspections and the count of unique facility names.
Apply double sort to the result:
- based on the owner_name in ascending order and
- based on the average inspections per facility in descending order.



with h as(
select 

owner_name, count(serial_number) as n_inspections,

count(distinct facility_name) as n_facilities

from los_angeles_restaurant_health_inspections


group by owner_name)


select owner_name, n_inspections, n_facilities, 

n_inspections/n_facilities::float as avg_inspections_per_facility

from h
order by owner_name, avg_inspections_per_facility desc
