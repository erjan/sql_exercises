
Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.


Note: The session starts when state=1 and ends when state=0.


with cte_start as 
(select * , row_number() over(partition by cust_id order by timestamp ) as rn from cust_tracking where state=1), 
cte_stop as (select * , row_number() over(partition by cust_id order by timestamp ) as rn from cust_tracking where state=0),


h2 as(
select 

a.cust_id, 
(cast(b.timestamp as time)/3600 - cast(a.timestamp as time)/3600)  as hours

from cte_start a join cte_stop b on a.cust_id = b.cust_id and a.rn = b.rn)

select cust_id, sum(hours) from h2 group by cust_id
