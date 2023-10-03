Some forecasting methods are extremely simple and surprisingly effective. Naïve forecast is one of them; we simply set all forecasts to be the value of the last observation. Our goal is to develop a naïve forecast for a new metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost) in our dataset and measure its accuracy.


To develop this forecast,  sum "distance to travel"  and "monetary cost" values at a monthly level before calculating "distance per dollar". This value becomes your actual value for the current month. The next step is to populate the forecasted value for each month. This can be achieved simply by getting the previous month's value in a separate column. Now, we have actual and forecasted values. This is your naïve forecast. Let’s evaluate our model by calculating an error matrix called root mean squared error (RMSE). RMSE is defined as sqrt(mean(square(actual - forecast)). Report out the RMSE rounded to the 2nd decimal spot.


with h as(
select 

*, extract(month from request_date)as month
--distance_to_travel/monetary_cost as dist_per_dollar


from uber_request_logs),


h2 as(
select 

month,
sum(distance_to_travel) as m_dist_travel,
sum(monetary_cost)as m_mcost
from h

group by month order by month),

h3 as(
select 

month,m_dist_travel/m_mcost as monthly_distance_per_dollar

from h2),
h4 as(
select month,monthly_distance_per_dollar,
lag(monthly_distance_per_dollar,1) over(order by month) as prev_monthly_distance_per_dollar
from h3),

h5 as(
select month, monthly_distance_per_dollar, prev_monthly_distance_per_dollar,
power(prev_monthly_distance_per_dollar-monthly_distance_per_dollar ,2) as power
from h4)


select round(sqrt(avg(power))::decimal,2) as rmse from h5

