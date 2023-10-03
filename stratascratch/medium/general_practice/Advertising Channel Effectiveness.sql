Find the average effectiveness of each advertising channel in the period from 2017 to 2018 (both included). The effectiveness is calculated as the ratio of total money spent to total customers aquired.


Output the advertising channel along with corresponding average effectiveness. Sort records by the average effectiveness in ascending order.



select 

advertising_channel,
sum(money_spent)/sum(customers_acquired)::float as ef

from uber_advertising where year between 2017 and 2018

group by advertising_channel
order by ef desc
