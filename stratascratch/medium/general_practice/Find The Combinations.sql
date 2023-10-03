Find all combinations of 3 numbers that sum up to 8. Output 3 numbers in the combination but avoid summing up a number with itself.

select 

distinct t1.number, t2.number, t3.number

from transportation_numbers t1 inner join transportation_numbers t2
on t1.number <> t2.number inner join transportation_numbers t3 on t2.number <> t3.number and t1.number <> t3.number
where t1.number + t2.number + t3.number = 8
