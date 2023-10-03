Find the monthly active users for January 2021 for each account. Your output should have account_id and the monthly count for that account.

select account_id, count(distinct user_id) from sf_events
where date between '2021-01-01' and '2021-01-31'
group by account_id
