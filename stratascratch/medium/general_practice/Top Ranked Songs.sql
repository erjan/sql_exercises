Find songs that have ranked in the top position. Output the track name and the number of times it ranked at the top. Sort your records by the number of times the song was in the top position in descending order.


select 


trackname,
count(position) as times_top1

from spotify_worldwide_daily_song_ranking
where position = 1
group by trackname
order by times_top1 desc
