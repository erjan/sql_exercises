-- intro
-- you will need to know aggregate functions before attempting the other questions.

-- We would like to find the total weight of cats grouped by age. But only return those groups with a total weight larger than 12.

select age,sum(weight)  as total_weight
from cats 
group by age
having sum(weight) > 12
order by age