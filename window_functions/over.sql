
-- OVER-----------------------------------------------


--1 
-- The cats must be ordered by name and will 
-- enter an elevator one by one. We would like to know what the running total weight is.


select 
name,
sum(weight) over( order by name) as running_total_weight
 from cats 


-- 2
-- The cats must be ordered first by breed and second by name. They are about to enter an elevator one by one. When all the cats of the same breed have entered they leave.

-- We would like to know what the running total weight of the cats is.

select 
name,
breed,
sum(weight) over ( partition by breed order by name) as running_total_weight
 from cats 


-- 3
-- The cats would like to see the average of the weight of them, the cat just after them and the cat just before them.
-- The first and last cats are content to have an average weight of consisting of 2 cats not 3.

select 
name,
weight,
avg(weight) over ( order by weight
ROWS between 1 preceding and 1 following)  as average_weight
 from cats 

 -- 4
-- The cats must be ordered by weight descending and will enter an elevator one by one. We would like to know what the running total weight is.

-- If two cats have the same weight they must enter separately

 select 
name,
sum(weight) over ( order by weight desc ROWS between unbounded preceding and current row) as running_total_weight
 from cats 
order by weight desc
