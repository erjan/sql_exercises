As part of the financial management in a large corporation, the CFO wants to review the expenses in all departments for the previous financial year (2022).

Write a SQL query to calculate the total expenditure for each department in 2022. Additionally, for comparison purposes, return the average expense across all departments in 2022.

Note: The output should include the department name, the total expense, and the average expense (rounded to 2 decimal places). The data should be sorted in descending order by total expenditure.



-------------------------------------------------------
WITH total_expense_by_dept AS
  (SELECT d.name,
          SUM(CASE
                  WHEN YEAR(e.date) = 2022 THEN e.amount ELSE 0
              END) AS total_expense
   FROM departments d
   LEFT JOIN expenses e ON d.id = e.department_id
   GROUP BY d.name)
SELECT te.name AS department_name,
       te.total_expense,
       ROUND(SELECT AVG(total_expense)
                FROM total_expense_by_dept),2) AS average_expense
FROM total_expense_by_dept te
ORDER BY total_expense DESC
