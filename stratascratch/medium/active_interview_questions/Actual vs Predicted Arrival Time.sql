Calculate the 90th percentile difference between Actual and Predicted arrival time in minutes for all completed trips within the first 14 days of 2022.


with h as(
select 

extract(epoch from (actual_time_of_arrival - predicted_eta))/60 as minutes


from trip_details
where status = 'completed' and request_at 
between '2022-01-01' and '2022-01-14')


select percentile_cont(0.9)within group(order by minutes) from h
