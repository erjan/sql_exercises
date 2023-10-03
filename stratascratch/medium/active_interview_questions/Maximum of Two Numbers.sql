Given a single column of numbers, consider all possible permutations of two numbers assuming that pairs of numbers (x,y) and (y,x) are two different permutations. Then, for each permutation, find the maximum of the two numbers.
Output three columns: the first number, the second number and the maximum of the two.


select f1.number,f2.number, 

case when f1.number > f2.number then f1.number else f2.number end as maxi


from deloitte_numbers f1 cross join deloitte_numbers f2 
