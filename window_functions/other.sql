

-- other ------------------------------------------

-- This SQL function can be made simpler by using the WINDOW statement. Please try and use the WINDOW clause.

-- Each cat would like to see what half, third and quartile they are in for their weight.

SELECT name, weight,
ntile(2) OVER window1 as by_half,
ntile(3) over window2 as thirds, 
ntile(4) over window3 as quart

FROM cats
WINDOW window1 as (order BY weight),
window2 as (order BY weight),
window3 as (order BY weight)
order by weight;

-- We would like to group our cats by color

-- Return 3 rows, each row containing a color and a list of cat names

select 
color,
array_agg(name) as names
from cats 
group by color
order by color desc


-- We would like to find the average weight of cats grouped by 
-- breed. Also, in the same query find the average weight of cats grouped by breed whose age is over 1

select breed,
avg(weight) as average_weight,
avg(weight) filter (where age> 1) as average_old_weight
from cats 
group by breed
order by breed