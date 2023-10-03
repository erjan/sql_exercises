Find the date with the highest total energy consumption from the Meta/Facebook data centers. Output the date along with the total energy consumption across all data centers.


with alldata as(
select * from fb_eu_energy

union  select * from fb_asia_energy

union  select * from fb_na_energy),

total2 as(
 select date, sum(consumption) as totalenergy  from alldata group by date order by totalenergy desc)
 
 select * from total2 where totalenergy = (select max(totalenergy) from total2)
