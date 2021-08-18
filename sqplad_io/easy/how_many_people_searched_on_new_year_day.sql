Write a query to return the total number of users who have searched on new year's day: 2021-01-01.

	
select count(distinct user_id) as num_searches from search 
where date = '2021-01-01'
-- group by user_id

    
