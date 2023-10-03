Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.


with h1 as(
select 
date,
Sum (downloads) Filter(Where paying_customer = 'no') as non_paying,
Sum (downloads) Filter(Where paying_customer = 'yes') as paying


from ms_user_dimension m1 
left join ms_acc_dimension m2 on m1.acc_id = m2.acc_id 
left join ms_download_facts m3 on m3.user_id = m1.user_id

group by date order by date)

select date, non_paying, paying from h1
where non_paying > paying
