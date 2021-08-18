Write a query to return the number of busy days and slow days in May 2020 based on the number of movie rentals.
The order of your results doesn't matter.
If there are ties, return just one of them.


	-- my own solution
with h1 as (	
	
select extract(day from rental_ts) as d, 

count(rental_id) as count from rental 

where date(rental_ts) >='2020-05-01'

and date(rental_ts) <'2020-06-01'

group by d),


h2 as (
select 

case when count >=100 then 'busy' else 'slow' end as x

from h1)

select 'busy' as date_category, count(x) from h2
union
select 'slow' as date_category, 31 - count(x) from h2


-- official solution
SELECT date_category, COUNT(*)
FROM (
	SELECT  D.date,
	    CASE WHEN COUNT(*) >= 100 THEN 'busy' ELSE 'slow' END date_category
	FROM dates D
	LEFT JOIN (
		SELECT * FROM rental		
	) R
	ON D.date = DATE(R.rental_ts)
	WHERE D.date >= '2020-05-01'
	AND   D.date <= '2020-05-31'
	GROUP BY D.date
) X
GROUP BY date_category
;
