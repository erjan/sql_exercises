Write a query to return the name 
of the top song in the US and UK in the first
7 days of 2021: 2021-01-01 - 2021-01-07, respectively.


-- my solution

	
select country, title, num_plays from (

select song.title ,country, sum(num_plays) as num_plays from song inner join song_plays on song.song_id = song_plays.song_id
where country in ('UK', 'US') and date >= '2021-01-01' and date <= '2021-01-07'
group by song.title, country

order by  num_plays desc, country)k limit 2

-- my 2nd solution - much better!

with h as (

select 

  song.title,
    country,
  sum(num_plays) as num_plays
  
  from song inner join song_plays on song.song_id = song_plays.song_id
  where date >= '2021-01-01' and date <= '2021-01-07'
  group by song.title, country
  having country in ('UK', 'US')),
  
  
  h2 as (
select title, num_plays,country, 
	row_number()over(partition by country order by num_plays desc) as rank
from h)


select  country, title, num_plays from h2
where h2.rank = 1


-- official solution

WITH song_plays AS (
	SELECT 
	    S.song_id,
	    P.country,
	    MAX(S.title) AS title,	    	    
	    SUM(num_plays) num_plays
	FROM song_plays P
	INNER JOIN song S
	ON P.song_id = S.song_id
	WHERE P.date >= '2021-01-01'
	AND P.date <= '2021-01-07'	
	GROUP BY S.song_id, P.country
),
song_ranking AS(
	SELECT song_id, title, country, num_plays, ROW_NUMBER() OVER(PARTITION BY country ORDER BY num_plays DESC) AS ranking
	FROM song_plays
	WHERE country IN ('US', 'UK')
)
SELECT country, title, num_plays
FROM song_ranking
WHERE ranking = 1;
