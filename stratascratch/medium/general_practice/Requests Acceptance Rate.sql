Find the acceptance rate of requests which is defined as the ratio of accepted contacts vs all contacts. Multiply the ratio by 100 to get the rate.



select 



sum(case when ts_accepted_at is not null then 1 else 0 end)/count(*)::numeric *100.0  as rate


from airbnb_contacts
