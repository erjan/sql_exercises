Find the wine with the highest points to price ratio. Output the title, points, price, and the corresponding points-to-price ratio.


with h as(
select 

title, points, price,
points/price::numeric as points_price_ratio,
rank() over(order by points/price :: numeric desc) as rnk
from winemag_p2 -- where price is not null
)


select title, points, price,

points_price_ratio from h where points_price_ratio = (select max(points_price_ratio) from h)

