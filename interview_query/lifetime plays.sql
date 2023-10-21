

'''
  We have a table called song_plays that tracks each time a user plays a song.

Write a query to return the number of songs played on each date for each user

NOTE: If a user played the same song twice during the day count should be two.

song_plays table
  '''

SELECT 

user_id, date(date_played) as played_date, 
count(id) as number_of_plays
FROM song_plays

group by user_id, date(date_played)
