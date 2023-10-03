Find the average time (in seconds), per product, that needed to progress between steps. You can ignore products that were never used. Output the feature id and the average time.


with h as(
select

feature_id,
user_id, 
TIMESTAMP :: TIMESTAMP AS TIMESTAMP,

lag(timestamp,1) over(partition by feature_id, user_id order by step_reached asc)::timestamp as prev_timestamp
from facebook_product_features_realizations),

h2 as(
select feature_id, user_id, extract(epoch from timestamp - prev_timestamp) as elapsed_time from h
where prev_timestamp is not null)

select feature_id, avg(avg_time) from (
select feature_id, user_id, avg(elapsed_time) as avg_time
from h2 group by feature_id, user_id) k group by feature_id

