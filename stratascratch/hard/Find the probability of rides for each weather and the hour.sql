Find the probability of total rides each weather-hour combination constitutes
Output the weather, hour along with the corresponding probability.
Sort records by the weather and the hour in ascending order.

with h as(
select weather, hour,

count(*) as cnt

from lyft_rides

group by weather, hour

order by weather, hour),

total as(
select count(index)::decimal as total_cnt from lyft_rides)

select weather,hour, cnt/total_cnt as prob
from h left join total t on true
order by weather, hour
