What cities recorded the largest growth and biggest drop in order amount between March 11, 2019, and April 11, 2019. Just compare order amounts on those two dates. Your output should include the names of the cities and the amount of growth/drop.


with h as(
select 
pm.name,
order_timestamp_utc::date,
 lag(sum(amount),1)over(partition by pm.name
order by order_timestamp_utc::date desc) - sum(amount) as diff

from postmates_orders po inner join postmates_markets pm on 
po.city_id = pm.id

-- where order_timestamp_utc between '2019-03-11' and '2019-04-11'

group by 1,2)

select name, diff from h where diff = (select max(diff) from h) or diff = (select min(diff) from h)
