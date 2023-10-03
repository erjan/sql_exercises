Find the employee who earned most from working overtime. Output the employee name.




select employeename 

from sf_public_salaries where overtimepay = (select max(overtimepay) from sf_public_salaries)

