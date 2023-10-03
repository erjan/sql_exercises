Find the facility that got the highest number of inspections in 2017 compared to other years. Compare the number of inspections per year and output only facilities that had the number of inspections greater in 2017 than in any other year.
Each row in the dataset represents an inspection. Base your solution on the facility name and activity date fields.


with t as
(select facility_name, extract(year from activity_date) yr,
count(*) cnt,
max(count(*)) over(partition by facility_name) mx from los_angeles_restaurant_health_inspections group by facility_name,extract(year from activity_date) order by facility_name),
s as (
select facility_name,count(*) r from t where cnt=mx group by facility_name)

select * from t join s on t.facility_name=s.facility_name 
where cnt=mx and r=1 and yr=2017
