Calculate the running total (i.e., cumulative sum) energy consumption of the Meta/Facebook data centers in all 3 continents by the date. Output the date, running total energy consumption, and running total percentage rounded to the nearest whole number.

with h as(
select * from fb_eu_energy
union all
select * from fb_na_energy
union all
select * from fb_asia_energy),

h2 as(
select date, sum(consumption)as total_energy 
from h group by date order by date asc)

select
date,

SUM(total_energy) OVER (ORDER BY date ASC) AS cumulative_total_energy,

ROUND(SUM(total_energy) OVER (ORDER BY date ASC) * 100 /
  (SELECT sum(total_energy) from h2 ),0) as percentage_of_total_energy

from h2
