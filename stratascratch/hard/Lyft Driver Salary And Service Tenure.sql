Find the correlation between the annual salary and the length of the service period of a Lyft driver.



with h as(
select 

yearly_salary,
coalesce(end_date,  current_date) - start_date as service_duration
from lyft_drivers)


select corr( service_duration, yearly_salary)as correlation
from h
