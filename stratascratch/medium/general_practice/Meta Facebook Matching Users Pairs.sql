Find matching pairs of Meta/Facebook employees such that they are both of the same nation, different age, same gender, and at different seniority levels.
Output ids of paired employees.



select * from facebook_employees f1 join

facebook_employees f2 
on f1.id <> f2.id 

where f1.location = f2.location 
and f1.gender = f2.gender 
and f1.age <> f2.age and f1.is_senior <> f2.is_senior 
and f1.id is not null and f2.id is not null
