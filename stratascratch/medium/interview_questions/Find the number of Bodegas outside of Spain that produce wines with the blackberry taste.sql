Find the number of Bodegas (wineries with "bodega" pattern inside the name) outside of Spain that produce wines with the blackberry taste (description contains blackberry string). Group the count by country and region.
Output the country, region along with the number of bodegas.
Order records by the number of bodegas in descending order.


select country, region, count(distinct winery) as n_bodegas
from (
select 
country, region_1 as region,winery, description

from winemag_p1
union all

select country, region_2 as region, winery, description from winemag_p2
where region_1 != region_2) sub
where winery ilike '%Bodega%' and country <> 'ES' and description ilike '%blackberry%'

group by country, region order by n_bodegas desc
