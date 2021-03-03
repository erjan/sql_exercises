/*
shitty problem - bad description!

Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number 
of gold galleons needed to buy each non-evil wand of high power and age. Write a query 
to print the id, age, coins_needed, and power of the wands 
that Ron's interested in, sorted in order of descending power. If more than 
one wand has same power, sort the result in order of descending age.
*/


select w1.id, w2.age, w1.coins_needed, w1.power 
from wands w1 inner join wands_property w2 on w1.code = w2.code
where w2.is_evil = 0 and w1.coins_needed = (select min(coins_needed) from 
wands ws inner join wands_property wp on ws.code = wp.code where w2.age = wp.age and w1.power = ws.power)

order by  w1.power desc, w2.age desc
