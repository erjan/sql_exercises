Find artists with the highest number of top 10 ranked songs over the years.
Output the artist along with the corresponding number of top 10 rankings.


with h as(
select 

artist, count(distinct trackname) as top10 

from spotify_worldwide_daily_song_ranking
where position <=10
group by artist order by top10 desc)

select artist , top10 from h where top10 = (select max(top10) from h)
