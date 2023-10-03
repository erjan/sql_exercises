After a new user creates an account and starts watching videos, the user ID, video ID, and date watched are captured in the database. Find the top 3 videos most users have watched as their first 3 videos. Output the video ID and the number of times it has been watched as the users' first 3 videos.


In the event of a tie, output all the videos in the top 3 that users watched as their first 3 videos.


with h as(
select 
*,
rank()over(partition by user_id order by watched_at) as rnk
from videos_watched),

h2 as(
select * from h where rnk <=3),

h3 as(
select video_id, count(*) as x , dense_rank()over(order by count(*) desc) as rnk
from h2 group by video_id)

select video_id, x as n_in_first_3 from h3 where rnk <=3
