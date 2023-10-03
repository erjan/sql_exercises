Find continents that have the highest number of companies.
Output the continents along with the corresponding number of companies.


with h as(
select 

continent, count(company) as x

from forbes_global_2010_2014

group by continent )

select continent, x from h where x = (select max(x) from h)
