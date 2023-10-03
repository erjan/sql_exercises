Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.

with dec2019 as(
select 
country, sum(number_of_comments) as n_com

from fb_comments_count f1 right join fb_active_users
f2 on f1.user_id = f2.user_id where 
created_at between '2019-12-01' and '2019-12-31' 
and country is not null

group by country),

jan2020 as(
select 
country, sum(number_of_comments) as n_com

from fb_comments_count f1 right join fb_active_users
f2 on f1.user_id = f2.user_id where 
created_at between '2020-01-01' and '2020-01-31'
and country is not null

group by country),

dec2019_rank as(
select country, n_com, dense_rank()over(order by n_com desc) as rnk from dec2019
),

jan2020_rank as(
select country, n_com, dense_rank()over(order by n_com desc) as rnk from jan2020
)

select j.country from dec2019_rank d right join jan2020_rank j
on  d.country = j.country 
where j.rnk < d.rnk or d.country is null
