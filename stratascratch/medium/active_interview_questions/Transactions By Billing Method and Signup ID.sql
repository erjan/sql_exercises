Get list of signups which have a transaction start date earlier than 10 months ago from March 2021. For all of those users get the average transaction value and group it by the billing cycle.


Your output should include the billing cycle, signup_id of the user, and average transaction amount. Sort your results by billing cycle in reverse alphabetical order and signup_id in ascending order.


select 



billing_cycle, s.signup_id, avg(amt) as t

from signups s inner join transactions t on s.signup_id = t.signup_id join plans p on p.id = s.plan_id
where transaction_start_date < '2021-03-01'::date -10 * interval '1 month'
group by billing_cycle, s.signup_id
order by billing_cycle desc, s.signup_id asc
