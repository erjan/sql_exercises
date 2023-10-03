Find all people who earned more than the average in 2013 for their designation but were not amongst the top 5 earners for their job title. Use the totalpay column to calculate total earned and output the employee name(s) as the result.

SELECT main.employeename
FROM sf_public_salaries main
JOIN
  (SELECT jobtitle,
          avg(totalpay) AS avg_pay
   FROM sf_public_salaries
   WHERE YEAR = 2013
   GROUP BY jobtitle) aves ON main.jobtitle = aves.jobtitle
AND main.totalpay > aves.avg_pay
WHERE main.employeename in
    (SELECT employeename
     FROM
       (SELECT employeename,
               jobtitle,
               totalpay,
               rank() OVER (PARTITION BY jobtitle
                            ORDER BY totalpay DESC) rk
        FROM sf_public_salaries
        WHERE YEAR = 2013 ) sq
     WHERE rk > 5)
