Find the top 5 highest paid and top 5 least paid employees in 2012.
Output the employee name along with the corresponding total pay with benefits.
Sort records based on the total payment with benefits in ascending order.


with h as(
select 

employeename,
totalpaybenefits,
rank()over(order by totalpaybenefits desc) as highest_paid,

rank()over(order by totalpaybenefits asc) as least_paid

from sf_public_salaries where year = 2012)


select employeename, totalpaybenefits from h where highest_paid <=5 or least_paid<=5
