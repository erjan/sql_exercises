
Find all number pairs whose first number is smaller than the second one and the product of two numbers is larger than 11.
Output both numbers in the combination.


select 


distinct t1.number, t2.number
from transportation_numbers t1 inner join transportation_numbers t2

on t1.index <> t2.index

where t1.number < t2.number and t1.number * t2.number >11
