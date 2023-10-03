Find the top 3 facilities for each owner. The top 3 facilities can be identified using the highest average score for each owner name and facility address grouping.
The output should include 4 columns: owner name, top 1 facility address, top 2 facility address, and top 3 facility address. Order facilities with the same score alphabetically.


with h as(
select owner_name, facility_address, score, rnk from (
select 

owner_name,facility_address,
avg(score) as score,
row_number()over(partition by owner_name order by avg(score) desc,facility_address) as rnk
from los_angeles_restaurant_health_inspections u
group by owner_name, facility_address)k where rnk<=3)



select owner_name, 
max(case when rnk = 1 then facility_address else null end) as f1,
max(case when rnk = 2 then facility_address else null end) as f2,
max(case when rnk = 3 then facility_address else null end) as f3
from h

group by owner_name

