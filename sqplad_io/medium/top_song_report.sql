/*

Write a query to return yesterday's top song id for every 
country, respectively, during the first 7 days of 2021: 2021-01-01 - 2021-01-07
Return a unique row for each country
For simplicity, let's assume there is no tie.
The order of your results doesn't matter.

*/


-- my solution from similar problem - top song in uk us
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
	--WHERE country IN ('US', 'UK')
)
SELECT country, title, num_plays
FROM song_ranking
WHERE ranking = 1;


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
)
SELECT country, title, num_plays
FROM song_ranking
WHERE ranking = 1;
