Find the employee who has achieved the highest target.
Output the employee's first name along with the achieved target and the bonus.


select 

first_name, target, bonus

from employee where target in (select max(target) from employee)

