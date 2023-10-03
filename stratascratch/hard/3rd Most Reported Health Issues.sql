Each record in the table is a reported health issue and its classification is categorized by the facility type, size, risk score which is found in the pe_description column.


If we limit the table to only include businesses with Cafe, Tea, or Juice in the name, find the 3rd most common category (pe_description). Output the name of the facilities that contain 3rd most common category.



with third_category as(
select  pe_description,rnk from (
select 

pe_description,
count(*), dense_rank()over(order by count(*) desc) as rnk

from los_angeles_restaurant_health_inspections
where lower(facility_name) ilike '%cafe%' or 
lower(facility_name) ilike '%tea%' or 
lower(facility_name) ilike '%juice%'

group by pe_description)k where rnk = 3)


select u.facility_name from los_angeles_restaurant_health_inspections u join
third_category t on u.pe_description = t.pe_description

where lower(facility_name) ilike '%cafe%' or 
lower(facility_name) ilike '%tea%' or 
lower(facility_name) ilike '%juice%'
