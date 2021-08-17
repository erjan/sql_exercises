

/*

Write a query to return the top 5 artists id for US on New Year's day: 2021-01-01.
For simplicity, we can assume there is no tie.
The order of your results doesn't matter.


не решил сам . потому что не понял вопроса - тут надо сумму юзать чтоб ответ получить, я же считал count
*/

with h1 as (

select song.artist_id, country, sum(num_plays) as num_plays 
  from song inner join song_plays on song.song_id = song_plays.song_id
  where country = 'US' and date = '2021-01-01'

  group by song.artist_id, country
  
order by num_plays desc)

select artist_id from h1 limit 5
