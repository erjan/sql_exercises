Find the cheapest and the most expensive variety in each region. Output the region along with the corresponding most expensive and the cheapest variety. Be aware that there are 2 region columns, price from that row applies to both of them.


with h as(
select variety, price, region_1 as region from winemag_p1 union all
select variety,price, region_2 as region from winemag_p1 order by variety),

h2 as(
select *, 

row_number()over(partition by region order by price desc) as expensive_rank,

row_number()over(partition by region order by price asc) as cheap_rank from h where price is not null and region is not null)

select 
region,

max(case when expensive_rank = 1 then variety else null end) as most_exp_variety,
min(case when cheap_rank = 1 then variety else null end) as most_cheap_variety
from h2
group by region 
