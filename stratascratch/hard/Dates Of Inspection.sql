Find the latest inspection date for the most sanitary restaurant(s). Assume the most sanitary restaurant is the one with the highest number of points received in any inspection (not just the last one). Only businesses with 'restaurant' in the name should be considered in your analysis.
Output the corresponding facility name, inspection score, latest inspection date, previous inspection date, and the difference between the latest and previous inspection dates. And order the records based on the latest inspection date in ascending order.



with cle as 
(
select distinct facility_name from los_angeles_restaurant_health_inspections
where upper(facility_name) like '%RESTAURANT%'
and score = (select max(score) from los_angeles_restaurant_health_inspections
where upper(facility_name) like '%RESTAURANT%')
)

select
A.facility_name,score,activity_date,prev_activity_date,
activity_date-prev_activity_date as number_of_days_between_high_scoring_inspections
from
(select *,rank() over(partition by facility_name order by activity_date desc) as rnk,
lead(activity_date,1) over(partition by facility_name order by activity_date desc) as prev_activity_date
from los_angeles_restaurant_health_inspections) A
inner join cle B
on A.facility_name = B.facility_name
where rnk = 1
order by activity_date
