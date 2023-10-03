Output share of US users that are active. Active users are the ones with an "open" status in the table.




with h as(

select count(user_id) as total_users,

count(case when status = 'open' then 1 else null end ) as active_users 

from fb_active_users where country = 'USA' )


select active_users/total_users::float as active_users_share from h


