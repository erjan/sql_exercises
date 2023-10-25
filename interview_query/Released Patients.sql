'''
A hospital is studying patient flows to optimize their resource placement.

Write a query to find all dates where the hospital released more patients than the day prior.

Note: You may assume that the table has no missing dates.
'''

with h as (
select 

release_date as today,
sum(released_patients)as patients_today

 from released_patients group by release_date),


h2 as(
 select today, patients_today, 
 
 lag(patients_today,1)over(order by today) 
 as yesterday_patients from h)


 select today as release_date, patients_today as released_patients from h2 where patients_today > yesterday_patients

--------------------------------------------------------------------------------------------------------------------------

WITH cte AS
  (SELECT *,
          LAG(released_patients, 1) OVER (ORDER BY release_date) AS prev_released_patients
   FROM released_patients)

SELECT release_date,
       released_patients
FROM cte
WHERE released_patients > prev_released_patients
