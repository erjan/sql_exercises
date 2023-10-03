Calculate the percentage of spam posts in all viewed posts by day. A post is considered a spam if a string "spam" is inside keywords of the post. Note that the facebook_posts table stores all posts posted by users. The facebook_post_views table is an action table denoting if a user has viewed a post.


select 

post_date,

count(case when post_keywords ilike '%spam%' then 1 else null end)::float/count(fv.post_id)*100.0

from facebook_posts fp inner join facebook_post_views fv on fp.post_id = fv.post_id

group by post_date
