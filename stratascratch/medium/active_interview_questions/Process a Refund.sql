Calculate and display the minimum, average and the maximum number of days it takes to process a refund for accounts opened from January 1, 2019. Group by billing cycle in months.


Note: The time frame for a refund to be fully processed is from settled_at until refunded_at.

select 

billing_cycle_in_months,
min(refunded_at-settled_at) as mindays,

avg(refunded_at-settled_at)   as avg_days,

max(refunded_at-settled_at) as maxdays


from noom_signups s
inner join noom_transactions n2 on n2.signup_id = s.signup_id inner join noom_plans p on p.plan_id = s.plan_id

where started_at >= '2019-01-01'

 group by billing_cycle_in_months
