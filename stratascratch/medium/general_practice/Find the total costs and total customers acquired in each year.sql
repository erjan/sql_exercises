Find the total costs and total customers acquired in each year.
Output the year along with corresponding total money spent and total acquired customers.


select 
year, sum(customers_acquired) , sum(money_spent)
from uber_advertising

group by year
