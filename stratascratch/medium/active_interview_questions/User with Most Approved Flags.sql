Which user flagged the most distinct videos that ended up approved by YouTube? Output, in one column, their full name or names in case of a tie. In the user's full name, include a space between the first and the last name.


with h as(
select 

user_firstname || ' ' || user_lastname as name,
video_id, uf.flag_id

from user_flags uf inner join flag_review fr
on uf.flag_id = fr.flag_id
where reviewed_outcome = 'APPROVED')

select name from (
select name, count(distinct video_id), 
rank()over(order by count(distinct video_id) desc) as rnk

from h
group by name)k where rnk = 1
