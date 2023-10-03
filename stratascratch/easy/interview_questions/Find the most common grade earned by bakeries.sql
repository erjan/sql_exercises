Find the most common grade earned by bakeries.



with h as (
select 

grade, count(*) as x

from los_angeles_restaurant_health_inspections

where facility_name ilike '%BAKERY%'

group by grade)

select grade from h where x = (select max(x) from h)
