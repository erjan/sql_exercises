   
/*
from spotify 
Write a query to return the name of the top song in the US on new year's day: 2021-01-01.

*/

select title from song inner join song_plays  on song.song_id = song_plays.song_id 

where date='2021-01-01' and country = 'US'
order by num_plays desc limit 1
