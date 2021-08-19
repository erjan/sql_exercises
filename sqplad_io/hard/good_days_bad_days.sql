Write a query to return the number of good days and bad days in May 2020 based on number of daily rentals.
Return the results in one row with 2 columns from left to right: good_days, bad_days.
good day: > 100 rentals.
bad day: <= 100 rentals.
Hint (For users already know OUTER JOIN), you can use dates table
Hint: be super careful about datetime columns.
Hint: this problem could be tricky, feel free to explore the rental table and take a look at some data.


-- my ugly solution
with h1 as (



select extract( day from date(rental_ts))  as day, count(rental_id) as num_rentals
  
from rental 
 where extract( month from date(rental_ts)) =5 and 
       extract( year from date(rental_ts)) = 2020	      	  
group by extract( day from date(rental_ts))  ),

h2 as (


select extract(day from date) as day from dates
  where extract(month from date) = 5 and extract(year from date) = 2020
),
h3 as (

select h2.day, num_rentals from h2 left outer join h1 on h1.day = h2.day),

h4 as (
select day_type , count(*) as x from (
select day, case when num_rentals is null or num_rentals <=100 then 'bad_days'
            when num_rentals > 100 then 'good_days' end as day_type from h3)k
			
			group by day_type),
			
		
h5 as (

select good_days  from (

select 
case when day_type = 'good_days' then x end as good_days,
case when day_type = 'bad_days' then x end as bad_days

from h4)o7
where good_days is not null),

h6 as (

select bad_days  from (

select 
case when day_type = 'good_days' then x end as good_days,
case when day_type = 'bad_days' then x end as bad_days

from h4)o7
where bad_days is not null)

select * from h5,h6

-- official solution 1
-- For people following my course (who have not learned outer join yet)

WITH daily_rentals AS (
	SELECT  
	 DATE(rental_ts) AS dt,
	 COUNT(*) AS num_rentals
	FROM rental
	WHERE DATE(rental_ts) >= '2020-05-01' 
        AND DATE(rental_ts) <= '2020-05-31' 
	GROUP BY dt
)    
SELECT 		    
    SUM(CASE WHEN num_rentals > 100 THEN 1
         ELSE 0 
         END) AS good_days,
    31 - SUM(CASE WHEN num_rentals > 100 THEN 1
         ELSE 0 
         END) AS bad_days
FROM daily_rentals;


-- official solution 2

-- (For users who already know OUTER JOIN):

WITH daily_rentals AS (
  SELECT  
	  D.date AS dt,
	  COUNT(R.rental_id) AS num_rentals
  FROM dates D
  LEFT JOIN rental R 
  ON D.date = DATE(R.rental_ts)
  WHERE D.date >= '2020-05-01'
  AND D.date <= '2020-05-31' 
  GROUP BY D.date
)
SELECT
    SUM(CASE WHEN num_rentals >100 THEN 1 ELSE 0 END) AS good_days,
    SUM(CASE WHEN num_rentals <=100 THEN 1 ELSE 0 END) AS bad_days
FROM daily_rentals;

