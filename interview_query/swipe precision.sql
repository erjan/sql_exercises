'''
  There are two tables. One table is called swipes that holds a row for every Tinder swipe and contains a boolean column that determines if the swipe was a right or left swipe called is_right_swipe. The second is a table named variants that determines which user has which variant of an AB test.

Write a SQL query to output the average number of right swipes for two different variants of a feed ranking algorithm by comparing users that have swiped 10, 50, and 100 swipes.

Note: Users have to have swiped at least 10 times to be included in the subset of users to analyze the mean number of right swipes.
  '''
  
with rightswipecount as(

    select v.id, v.variant, s.user_id, count(s.user_id) as swipe_threshold,
    sum(s.is_right_swipe) as swipeCount
    from variants v inner join swipes s on s.user_id = v.user_id

    group by s.user_id
    having swipe_threshold in (10,50,100)
)

select avg(swipeCount) as mean_right_swipes, 
count(user_id) as num_users,  swipe_threshold, variant
from rightswipecount

group by  variant

---------------------------------------------------------------------------------------



With A as (


    select 
    v.variant,
    s.*
    from variants v 
    join swipes s 
    on v.user_id=s.user_id
)

, B as (

    select 
    user_id,
    variant,
    count(*)swipes,
    sum(case when is_right_swipe = TRUE then 1 else 0 end)right_swipes
    from A 
    group by 1,2
)

, C as (
    select
    *,
    case when swipes>=100 then 100
    when swipes >=50 then 50 
    when swipes>=10 then 10 
    else Null end as swipe_threshold
    from B
)
, D as (
select 
variant,
swipe_threshold,
avg(right_swipes) as mean_right_swipes,
count(*)num_users
from C 
where swipe_threshold is not Null 
group by 1,2)

select 
variant,
mean_right_swipes,
swipe_threshold,
num_users
from D
