For the video (or videos) that received the most user flags, how many of these flags were reviewed by YouTube? Output the video ID and the corresponding number of reviewed flags.

with h as(
select 

video_id,

sum(case when f.reviewed_by_yt = TRUE then 1 else 0 end) as reviewed, 
 rank()over( order by count(f.flag_id) desc) as rnk

from user_flags u inner join flag_review f on u.flag_id = f.flag_id
group by video_id),

h2 as(
select video_id,  reviewed from h where rnk = 1)

select * from h2
