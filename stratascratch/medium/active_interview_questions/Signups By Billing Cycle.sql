Write a query that returns a table containing the number of signups for each weekday and for each billing cycle frequency.


Output the weekday number (e.g., 1, 2, 3) as rows in your table and the billing cycle frequency (e.g., annual, monthly, quarterly) as columns. If there are NULLs in the output replace them with zeroes.



select 



extract('dow' from signup_start_date ) as weekday,

count(distinct case when billing_cycle = 'annual' then signup_id end) as annual,
count(distinct case when billing_cycle = 'monthly' then signup_id end) as monthly,
count(distinct case when billing_cycle = 'quarterly' then signup_id end) as quarterly

from signups s inner join plans p on s.plan_id = p.id

group by 1
