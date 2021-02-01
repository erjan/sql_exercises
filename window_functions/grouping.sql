


-- Grouping the output

-- We are worried our cats are too fat and need to diet.

-- We would like to group the cats into quartiles by their weight.

select 
name,
weight,
ntile(4) over (order by weight) as  weight_quartile
from cats 
order by weight


-- Cats are fickle. Each cat would like to lose weight to be the equivalent weight of the cat weighing just less than it.

-- Print a list of cats, their weights and the weight difference between them and the nearest lighter cat ordered by weight.

select 
name,weight,

coalesce(weight - lag(weight, 1) over ( order by weight),0) as weight_to_lose
from cats 
order by weight

-- The cats now want to lose weight according to their breed. Each cat would like to lose weight to be the equivalent weight of the cat in the same breed weighing just less than it.

-- Print a list of cats, their breeds, weights and the weight difference between them and the nearest lighter cat of the same breed.

select 
name,breed,weight,
coalesce(weight - lag(weight, 1) over (partition by breed order by weight) ,0) as weight_to_lose
from cats 
order by weight

-- Cats are vain. Each cat would like to pretend it has the lowest weight for its color.

-- Print cat name, color and the minimum weight of cats with that color.

select 
name, color,
first_value(weight) over (partition by color order by weight asc) as lowest_weight_by_color
from cats 
order by color,name

-- Each cat would like to see the next heaviest cat's weight when grouped by breed. If there is no heavier cat print 'fattest cat'

-- Print a list of cats, their weights and either the next heaviest cat's weight or 'fattest cat'

select 
name, weight, breed,
coalesce(cast( lead(weight,1) over (partition by breed order by weight)  as varchar), 'fattest cat') as next_heaviest
 from cats order by weight


 -- The cats have decided the correct weight is the same as the 4th lightest cat. All cats shall have this weight. Except in a fit of jealous rage they decide to set the weight of the lightest three to 99.9

-- Print a list of cats, their weights and their imagined weight

select name, weight, coalesce(nth_value(weight,4) over (order by weight) , 99.9)
as imagined_weight
from cats 
order by weight

-- The cats want to show their weight by breed. The cats agree that they should show the second lightest cat's weight (so as not to make other cats feel bad)

-- Print a list of breeds, and the second lightest weight of that breed

select 
distinct breed,

nth_value(weight, 2) over (partition by breed order by weight
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )

as imagined_weight
from cats 
order by breed


