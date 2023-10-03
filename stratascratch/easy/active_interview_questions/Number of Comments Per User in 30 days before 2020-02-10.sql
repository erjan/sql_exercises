Return the total number of comments received for each user in the 30 or less days before 2020-02-10. Don't output users who haven't received any comment in the defined time period.


select 


user_id, sum(number_of_comments) as number_of_comments
from fb_comments_count
where created_at between '2020-02-10'::date -30*interval '1 day' and '2020-02-10'::date
group by user_id
