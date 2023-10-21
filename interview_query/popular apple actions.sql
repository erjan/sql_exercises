Write a query to determine the top 5 actions performed during the month of November 2020, for actions performed on an Apple platform (iPhone, iPad).

The events table tracks every time a user performs a certain action (like post_enter, etc.) on a platform (android, web, etc.).

The output should include the action performed and it’s rank in ascending order. If two actions are performed equally, they should have the same rank. 

-----------------------------------------

  
with h as(
select 

action,  count(*) as c

from events

where year(created_at) = 2020 and month(created_at) = 11
and platform in ('ipad', 'iphone')
group by action order by c desc),

h2 as(
select action,
dense_rank()over(order by c desc) as dranks,

rank()over(order by c desc)as ranks 
from h)

select action, dranks as ranks from h2 where ranks<=5

---------------------------------------------------------------------

WITH before_rankings AS (
	SELECT
		action,
		count(*) AS ranks
	FROM
		events
	WHERE
		year(created_at) = 2020
		AND month(created_at) = 11
		and(platform = 'iphone'
			OR platform = 'ipad')
	GROUP BY
		action
)
SELECT
	action,
	dense_rank() OVER (ORDER BY ranks DESC) AS ranks
FROM
	before_rankings
LIMIT 5
