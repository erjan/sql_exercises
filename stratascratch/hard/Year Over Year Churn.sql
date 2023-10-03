Find how the number of drivers that have churned changed in each year compared to the previous one. Output the year (specifically, you can use the year the driver left Lyft) along with the corresponding number of churns in that year, the number of churns in the previous year, and an indication on whether the number has been increased (output the value 'increase'), decreased (output the value 'decrease') or stayed the same (output the value 'no change').


with h as(
select start_date,extract( year from end_date) as end_year from lyft_drivers where end_date is not null),

h2 as(
select 
end_year, 
count(*) as n_churned,

coalesce(lag(count(*),1)over(order by end_year asc),0) as n_churned_prev


from h group by end_year)


select 

end_year, n_churned, n_churned_prev,
case when n_churned > n_churned_prev then 'increase'

when n_churned < n_churned_prev then 'decrease'
else 'no change' end as case
from h2
