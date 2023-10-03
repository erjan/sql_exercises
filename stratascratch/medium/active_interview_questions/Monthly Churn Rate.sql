Calculate the churn rate of September 2021 in percentages. The churn rate is the difference between the number of customers on the first day of the month and on the last day of the month, divided by the number of customers on the first day of a month.
Assume that if customer's contract_end is NULL, their contract is still active. Additionally, if a customer started or finished their contract on a certain day, they should still be counted as a customer on that day.


with cte as (select * from natera_subscriptions where contract_start <= '2021-09-01' and (contract_end <= '2021-09-30' or  contract_end is NULL))

select sum(churn)/count(*)::float * 100 from (select * ,case when contract_end < '2021-09-30' then 1 else 0 end  as churn from cte)t
