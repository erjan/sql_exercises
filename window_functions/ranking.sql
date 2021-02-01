


-- ranking-----------------------------------------------------------------------------

-- The cats form a line grouped by color. Inside each color group the cats order themselves by name. Every cat must have a unique number for its place in the line.

-- We must assign each cat a unique number while maintaining their color & name ordering.

select 
row_number() over (order by color,name) as unique_number,
name,
color
from cats 


-- We would like to find the fattest cat. Order all our cats by weight.

-- The two heaviest cats should both be 1st. The next heaviest should be 3rd.

select 
rank() over (order by weight desc ) as ranking,
weight, 
name
from cats 
order by ranking,name

-- For cats age means seniority, we would like to rank the cats by age (oldest first).

-- However we would like their ranking to be sequentially increasing.

select 
dense_rank() over (order by age desc) as ranking,
name,
age
 from cats
order by ranking , name 

-- Each cat would like to know what percentage of other cats weigh less than it

select 
name,
weight,
percent_rank() over (order by weight  ) *100 as percent
 from cats
order by weight 


-- Each cat would like to know what weight percentile it is in. This requires casting to an integer

select 
name,
weight,
cast ( cume_dist() over (order by weight) * 100 AS INT)  as percent
 from cats 
order by weight




