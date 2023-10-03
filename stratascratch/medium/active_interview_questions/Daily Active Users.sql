Find the average daily active users for January 2021 for each account. Your output should have account_id and the average daily count for that account.


with h as(
select * from sf_events
where extract(year from date) = 2021 and extract(month from date) = 1

), 

daily_users as(
select  date, account_id, count(distinct user_id) as users_count from h

group by date, account_id)


select account_id, sum(users_count)/31.0 as average from daily_users group by account_id
