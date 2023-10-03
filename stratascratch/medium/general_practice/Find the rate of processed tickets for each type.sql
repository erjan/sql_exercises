Find the rate of processed tickets for each type.



select 
type,
sum(case when processed is TRUE then 1 else 0 )::numeric/count(*) as processed_rate

from facebook_complaints

group by type

