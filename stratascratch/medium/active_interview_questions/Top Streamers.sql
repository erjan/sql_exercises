List the top 10 users who accumulated the most sessions where they had more streaming sessions than viewing. Return the user_id, number of streaming sessions, and number of viewing sessions.


with counter as (
select 
    user_id,
    SUM(case when session_type='streamer' then 1 else 0 end ) as stream_count,
    SUM(case when session_type='viewer' then 1 else 0 end ) as viewer_count,
    SUM(CASE WHEN session_type='streamer' THEN 1 else -1 end ) as counter
from twitch_sessions
group by user_id
),

filtering as(
select 
    *,
    dense_rank() OVER(order by counter desc) as ranking
from counter 
)

select user_id, stream_count, viewer_count
from filtering
where ranking<=10
and counter>0
order by ranking asc
