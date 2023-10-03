Return a distribution of users activity per day of the month



select
extract(day from post_date),
count(post_id)

from facebook_posts


group by extract(day from post_date)
