Find the global churn rate of Lyft drivers across all years. Output the rate as a ratio.




with h as(
select 

-- extract(year from start_date) as year,
count(case when end_date is not null then index else null end) as driver_gone,
count(*)::decimal as total
from lyft_drivers

-- group by extract(year from start_date)
)

select driver_gone/total::float from h
