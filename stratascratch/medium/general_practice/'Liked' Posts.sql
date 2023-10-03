Find the number of posts which were reacted to with a like.




select 

count(distinct fp.post_id)
from facebook_reactions fr inner join facebook_posts fp on fr.post_id = fp.post_id

where reaction = 'like'
