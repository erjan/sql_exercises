Find industries with the highest market value in Asia.
Output the industry along with the corresponding total market value.


with h as (select 

industry, sum(marketvalue) as x
from forbes_global_2010_2014

where continent = 'Asia'

group by industry order by x desc)


select * from h where x = (select max(x) from h)
