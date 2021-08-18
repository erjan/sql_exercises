Write a query to return the top artist id for every country on New Year's Day: 2021-01-01
Return a unique row for each country
For simplicity, let's assume there is no tie.
The order of your results doesn't matter.


-- my solution - the description is not clear, what top means.


with h1 as (

select country, artist_id, sum(num_plays) as n

from song inner join song_plays on 
song.song_id = song_plays.song_id
where date = '2021-01-01'
group by country, artist_id),

h2 as (
select country, artist_id, n,
row_number() over(partition by country order by n desc) as x

from h1)


select country, artist_id from h2
where x =1



WITH artist_plays AS (
    SELECT 
        S.artist_id,
        P.country,
        SUM(num_plays) num_plays	    
    FROM song_plays P
    INNER JOIN song S
    ON S.song_id = P.song_id
    WHERE P.date = '2021-01-01'
    GROUP BY 1,2
),

artist_ranking AS (
    SELECT 
    artist_id,
    country,
    ROW_NUMBER() OVER(PARTITION BY country ORDER BY num_plays DESC) ranking
FROM artist_plays
)

SELECT country, artist_id
FROM artist_ranking
WHERE ranking = 1;
    
