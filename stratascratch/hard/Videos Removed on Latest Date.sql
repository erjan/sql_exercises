For each unique user in the dataset, find the latest date when their flags got reviewed. Then, find total number of distinct videos that were removed on that date (by any user).
Output the the first and last name of the user (in two columns), the date and the number of removed videos. Only include these users who had at least one of their flags reviewed by Youtube. If no videos got removed on a certain date, output 0.


with h as(
select user_firstname, user_lastname, max(reviewed_date) as maxdate

from user_flags uf inner join flag_review f on uf.flag_id = f.flag_id  where reviewed_by_yt = TRUE  group by 1,2),

h2 as(

-- then, find total number of distinct videos that were removed on that date (by any user)
select reviewed_date, count(distinct video_id) n_removed from user_flags as uf inner join

flag_review f on uf.flag_id = f.flag_id where lower(reviewed_outcome) = 'removed'
group by reviewed_date)

select h.*, coalesce(h2.n_removed,0) as n_removed from h left join h2 on h.maxdate = h2.reviewed_date
