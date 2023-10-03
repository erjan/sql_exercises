
Determine the change in the number of daily violations by calculating the difference between the count of current and previous violations by inspection date.
Output the inspection date and the change in the number of daily violations. Order your results by the earliest inspection date first.

select 
inspection_date, count(violation_id),
count(violation_id)-lag( count(violation_id),1)over(order by inspection_date) as prev_daily_violations


from sf_restaurant_health_violations
group by inspection_date
order by inspection_date
