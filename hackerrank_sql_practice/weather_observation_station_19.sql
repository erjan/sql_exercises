/*
Consider (a,c) and (b,d)  to be two points on a 2D plane where (a,b) are the 
respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in
*/

select round(sqrt(power((b - a),2) + power((d-c),2)) ,4) from (
select 
min(LAT_N) as a, max(LAT_N) as b,
min(LONG_W)as c, max(LONG_W) as d
from station)k
