/*
Write a query to return the user who received the most friend requests in January 2021.
Hint: We can assume there is one and only one person with the most requests, there is no tie.
Requests from the same sender should be deduplicated when counting.
*/


with h1 as (
select * from friend_request where extract(year from request_dt) = 2021 and
extract(month from request_dt) = 1),

h2 as (
select  recipient_id, count(distinct sender_id) as x from h1 group by recipient_id
order by x  desc limit 1)

select recipient_id from h2
