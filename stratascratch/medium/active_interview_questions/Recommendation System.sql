You are given the list of Facebook friends and the list of Facebook pages that users follow. Your task is to create a new recommendation system for Facebook. For each Facebook user, find pages that this user doesn't follow but at least one of their friends does. Output the user ID and the ID of the page that should be recommended to this user.

select distinct u.user_id, p.page_id from users_friends u join 


users_pages p on u.friend_id = p.user_id

where not exists( select * from users_pages pg where pg.user_id = u.user_id and pg.page_id = p.page_id)
