Find the employee who earned the lowest total payment with benefits from a list of employees who earned more from other payments compared to their base pay. Output the first name of the employee along with the corresponding total payment with benefits.


with h as(
select 

lower(split_part(employeename,' ',1)) as name, totalpaybenefits
from sf_public_salaries s1 where otherpay > basepay)


select name, totalpaybenefits from h where totalpaybenefits = (select min(totalpaybenefits) from h)
