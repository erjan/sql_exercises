Find the number of days a US track has stayed in the 1st position for both the US and worldwide rankings. Output the track name and the number of days in the 1st position. Order your output alphabetically by track name.


If the region 'US' appears in dataset, it should be included in the worldwide ranking.


select a.trackname, count(*)
from spotify_daily_rankings_2017_us a
inner join spotify_worldwide_daily_song_ranking b
on a.date = b.date and a.trackname = b.trackname and a.position = b.position
where a.position = 1 group by 1 order by 1
