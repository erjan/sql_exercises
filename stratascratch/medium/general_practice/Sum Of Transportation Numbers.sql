Find the sum of all values between the lowest and highest transportation numbers (i.e., exclude the lowest and highest numbers in your sum).
Your output should have 3 columns: the minimum number, maximum number, and summation.


select 


min(number), max(number), sum(number) - min(number) - max(number)
from transportation_numbers;
