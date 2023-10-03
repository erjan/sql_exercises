Find the median price for each wine variety across both datasets. Output distinct varieties along with the corresponding median price.


select 
distinct variety, percentile_cont(0.5)within group(order by price )as median_price
from
(select variety, price from winemag_p1
union all
select variety,price from winemag_p2)k

group by variety order by variety
