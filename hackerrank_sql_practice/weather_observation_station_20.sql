/*
A median is defined as a number separating the higher half 
of a data set from the lower half. Query the median of the 
Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.

*/


with ordered as (
select LAT_N from station order by LAT_N desc),

total_num as (
select count(LAT_N) as c from station),

actual_pos as (
select round(c/2) as x from total_num)

select round(LAT_N,4) from (
select LAT_N , row_number() over( order by LAT_N desc) as r from ordered )k 
where r = (select x from actual_pos)
