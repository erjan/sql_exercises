Count the number of users who made more than 5 searches in August 2021.




select count(user_id) from(
select  user_id, count( search_id) as x from fb_searches
where date between '2021-08-01' and '2021-08-31'
group by user_id)a
where x > 5
