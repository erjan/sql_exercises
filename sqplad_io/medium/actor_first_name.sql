Write a query to return the number of actors whose first name starts with 'A', 'B', 'C', or others.
The order of your results doesn't matter.
You need to return 2 columns:
The first column is the group of actors based on the first letter of their first_name, use the following: 'a_actors', 'b_actors', 'c_actors', 'other_actors' to represent their groups.
Second column is the number of actors whose first name matches the pattern.


 
  with helper as (
  select 
  
  case 
  when first_name like 'A%' then 'a_actors'
  when first_name like 'B%' then 'b_actors'
  when first_name like 'C%' then 'c_actors'
  else 'other_actors' end as actor_category
  from actor)
  
  select actor_category, count(*) as count from helper 
  group by actor_category

    
