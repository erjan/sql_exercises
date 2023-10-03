Find the number of wines with and without designations per country.
Output the country along with the total without designations, total with designations, and the final total of both.



select 


country, 

coalesce(sum(case when designation is null then 1 else 0 end),0) as total_without_designation,
coalesce(sum(case when designation is not null then 1 else 0 end),0) as total_with_designation,

count(*) as grand_total

from winemag_p2 group by country
