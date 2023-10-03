Find the highest salary among salaries that appears only once.


select salary from employee

group by salary
having count(distinct salary) = 1
order by salary desc limit 1

---------------------------------------
SELECT
    MAX(salary) AS max_salary
FROM
(
SELECT
        salary
FROM employee
GROUP BY salary
HAVING COUNT(salary) = 1
) AS t;
