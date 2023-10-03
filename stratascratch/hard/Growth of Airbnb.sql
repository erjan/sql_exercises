Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric. The rate of growth is calculated by taking ((number of hosts registered in the current year - number of hosts registered in the previous year) / the number of hosts registered in the previous year) * 100.
Output the year, number of hosts in the current year, number of hosts in the previous year, and the rate of growth. Round the rate of growth to the nearest percent and order the result in the ascending order based on the year.
Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.




with h as(
select 

*,

extract(year from host_since::date) as year

from airbnb_search_details where host_since is not null),

h2 as(
select  year, 
count(id) as num_host_registered from h group by year order by year),

h3 as(
select year, num_host_registered, lag(num_host_registered,1) over(order by year) as prev
from h2)


select year,num_host_registered,prev as prev_year_host,
 round(((num_host_registered - prev)/(cast(prev AS numeric)))*100) estimated_growth
from h3




