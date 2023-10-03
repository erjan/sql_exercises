Find all provinces which produced more wines in 'winemag_p1' than they did in 'winemag_p2'.
Output the province and the corresponding wine count.
Order records by the wine count in descending order.


with w1 as(
select

province, count(id) as wine_count
from winemag_p1
where province is not null
group by province
order by wine_count desc),

w2 as(

select

province, count(id) as wine_count
from winemag_p2
where province is not null
group by province
order by wine_count desc)

select w1.province, w1.wine_count, w2.wine_count
from w2 inner join w1 on w1.province = w2.province
where w1.wine_count > w2.wine_count
