What are the top two (ranked in decreasing order) single-channel media types that correspond to the most money the grocery chain had spent on its promotional campaigns?




select media_type, money_spent from (
select 

media_type,
sum(cost) as money_spent,
rank()over(order by sum(cost)desc) as rnk
from facebook_sales_promotions

group by media_type) k where rnk<3
