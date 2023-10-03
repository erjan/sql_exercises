You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. For each date, find the difference between the distance-per-dollar for that date and the average distance-per-dollar for that year-month. Distance-per-dollar is defined as the distance traveled divided by the cost of the ride.


The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).
You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.


-- Create distance-per-dollar column
WITH added_distance_per_dollar AS(
    select request_id, request_date, request_status, (distance_to_travel/monetary_cost) as distance_per_dollar 
    from uber_request_logs
)

-- Create year-month column
, added_year_month AS(
    select *, to_char(request_date, 'YYYY-MM') as year_month
    from added_distance_per_dollar
)

-- Adding average distance-per-dollar per year_month
, added_year_month_avg AS(
    select *, avg(distance_per_dollar) OVER(partition by year_month) as year_month_avg
    from added_year_month
)

-- Adding difference between distance_per_dollar and year_month_avg
, added_difference AS (
    select *, (distance_per_dollar-year_month_avg) difference
    from added_year_month_avg
)

-- Adding absolute_average_difference
, absolute_average_difference AS (
select request_id,	request_date,	request_status, year_month, round(cast(abs(difference) as numeric), 2) as absolute_average_difference 
from added_difference
)

-- Final solution
select distinct(year_month), absolute_average_difference
from absolute_average_difference
