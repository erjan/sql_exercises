Rank guests based on their ages.
Output the guest id along with the corresponding rank.
Order records by the age in descending order.


select 

guest_id,age, rank()over(order by age desc) as r

from airbnb_guests
order by age desc

