Find employees who have worked for Uber for more than 2 years (730 days) and check to see if they're still part of the company. Output 'Yes' if they are and 'No' if they are not. Use May 1, 2021 as your date of reference when calculating whether they have worked for more than 2 years since their hire date.
Output the first name, last name, whether or not the employee is still working for Uber, and the number of years at the company.


SELECT first_name,
       last_name,
       (COALESCE(termination_date, '2021-05-01') - hire_date)::float/365 AS years_spent,
       CASE
           WHEN termination_date IS NULL THEN 'Yes'
           ELSE 'No'
       END AS still_employed
FROM uber_employees
WHERE (COALESCE(termination_date, '2021-05-01') - hire_date) > 730
