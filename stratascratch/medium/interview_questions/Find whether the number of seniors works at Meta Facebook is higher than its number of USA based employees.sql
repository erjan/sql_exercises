Find whether the number of senior workers (i.e., more experienced) at Meta/Facebook is higher than number of USA based employees at Facebook/Meta.
If the number of seniors is higher then output as 'More seniors'. Otherwise, output as 'More USA-based'.


with usbased as(
select 

count(*) as usabased
from facebook_employees where location = 'USA'),

senior as(
select 

count(*) as senior_worker
from facebook_employees where is_senior=TRUE)

select case when usabased<senior_worker then 'More seniors' else 'More USA-based' end as winner from usbased cross join (select * from senior)k
 
