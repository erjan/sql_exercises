Find the student with the highest efficiency for mathematics?

The efficiency is defined as the score divided by hours studied.
Output the result along with the student id, hours studies and the obtained score for mathematics.
Sort the results based on the efficiency in the descending order.



with h as(
select 

student_id, hrs_studied,sat_math, sat_math/hrs_studied::float as effic,
rank()over(order by sat_math/hrs_studied::float desc ) as rnk

from sat_scores
where hrs_studied > 0
order by effic desc )

select student_id, hrs_studied,sat_math, effic from h where rnk = 1
