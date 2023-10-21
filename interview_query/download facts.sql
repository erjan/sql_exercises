'''
Given two tables: accounts, and downloads, find the average number of downloads for free vs paying accounts, broken down by day.

Note: You only need to consider accounts that have had at least one download before when calculating the average.

Note: round average_downloads to 2 decimal places.
'''

select
download_date,
paying_customer, 
avg(downloads) as average_downloads

from accounts a inner join downloads d
on d.account_id = a.account_id
group by download_date, paying_customer
-------------------------------------------------------------------------------------------------------------------

SELECT download_date, paying_customer, ROUND(AVG(downloads),2) AS average_downloads 
FROM accounts a
JOIN downloads b ON a.account_id = b.account_id
GROUP BY download_date, paying_customer
