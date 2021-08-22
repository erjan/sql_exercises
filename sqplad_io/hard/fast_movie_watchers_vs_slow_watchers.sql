/*
Write a query to return the number of fast movie watchers vs slow movie watchers.
fast movie watcher: by average return their rentals within 5 days.
slow movie watcher: takes an average of >5 days to return their rentals.
Most customers have multiple rentals over time, you need to first compute the number of days for each rental transaction, then compute the average on the rounded up days. e.g., if the rental period is 1 day and 10 hours, count it as 2 days.
Skip the rentals that have not been returned yet, e.g., rental_ts IS NULL.
The orders of your results doesn't matter.
A customer can only rent one movie per transaction.


*/
-- this is my wrong solution, it's cuz i calculated the num of days and duration wrong way!

    
with h as (
select 
customer_id,
rental_id,
DATE_PART('hour', AGE(  return_ts, rental_ts)) AS hours,
DATE_PART('day', AGE(  return_ts, rental_ts)) AS days
from rental	
where return_ts is not null ),

h2 as (
select 
rental_id,
customer_id,
hours, days,
case when hours > 0 then days+1 else days end as rounded_days
from h),


h3 as (
select customer_id, round(avg(rounded_days)) as d from h2
group by customer_id),

h4 as ( 
select 
  CASE WHEN d <= 5 THEN 'fast_watcher'
  when d > 5 then 'slow watcher' end as tip
  
from h3) 

select tip as watcher_category , count(*) from h4
group by tip


-- my working solution - after looking up

with h as (
select 
customer_id,
rental_id,
  extract(days from age(return_ts, rental_ts))+1 as avg_days
from rental	
where return_ts is not null ),

h2 as(

select customer_id, avg(avg_days) as total
from h
group by customer_id)


select watcher_category, count(*) from (
select 
customer_id, 
case when total > 5 then 'slow_watcher' 
     when total <=5 then 'fast_watcher' end as watcher_category
			
from h2)k
group by watcher_category

-- official solution
WITH average_rental_days AS (
	SELECT 
	    customer_id,        
	    AVG(EXTRACT(days FROM (return_ts - rental_ts) ) + 1) AS average_days
	FROM rental
	WHERE return_ts IS NOT NULL
	GROUP BY 1
)
SELECT CASE WHEN average_days <= 5 THEN 'fast_watcher'
            WHEN average_days > 5 THEN 'slow_watcher'
            ELSE NULL
            END AS watcher_category,
        COUNT(*)
FROM average_rental_days
GROUP BY watcher_category;

    
