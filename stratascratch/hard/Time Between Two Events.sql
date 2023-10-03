Meta/Facebook's web logs capture every action from users starting from page loading to page scrolling. Find the user with the least amount of time between a page load and their first scroll down. Your output should include the user id, page load time, first scroll down time, and time between the two events in seconds.


with h as(
select 

t1.user_id,
t1.timestamp as load_time,
t2.timestamp as scroll_time, t2.timestamp - t1.timestamp as duration


from facebook_web_log t1 join facebook_web_log t2 on t1.user_id = t2.user_id
where t1.action = 'page_load' and t2.action = 'scroll_down' and t2.timestamp > t1.timestamp),

h2 as(
select * , rank()over(order by duration) as rnk from h)

select user_id, load_time , scroll_time, duration::TIME from h2 where rnk = 1
