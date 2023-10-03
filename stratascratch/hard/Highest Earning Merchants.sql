For each day, find a merchant who earned the highest amount on a previous day. Round total amount to 2 decimals. Output the date and the name of the merchant but only for the days where the data from the previous day are available. In the case of multiple merchants having the same highest shared amount, your output should include all the names in different rows.


with h as(
select 
*,
order_timestamp::date as day

from doordash_orders d inner join doordash_merchants m on d.merchant_id = m.id),

 h2 as(
select 
merchant_id,
day,
round(cast(sum(total_amount_earned) as decimal ),2 ) as daily_total

from h group by day, merchant_id),

h3 as(
select day,  max(daily_total) as highest_total
from h2 group by day)


select cast(h2.day + interval '1 day' as date), name  from h2 join h3 on h3.day = h2.day join doordash_merchants d on d.id = h2.merchant_id
and h2.daily_total = h3.highest_total
