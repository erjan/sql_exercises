

'''
  You’re given two tables, payments and users. The payments table holds all payments between users with the payment_state column consisting of either "success" or "failed". 

How many customers that signed up in January 2020 had a combined (successful) sending and receiving volume greater than $100 in their first 30 days?

Note: The sender_id and recipient_id both represent the user_id.
  '''


with cte as (
    SELECT id, created_at as join_date FROM users
    where date(created_at) between date('2020-01-01') and date('2020-01-31')
),
total_transactions as(
select cte.id, sum(amount_cents)/100 as total
from cte join payments p
on (cte.id = sender_id  or cte.id = recipient_id)
and payment_state = 'success' 
and datediff(created_at,join_date)<=30
group by 1
order by 2 desc)

select count(id) as num_customers 
from total_transactions
where total >100
