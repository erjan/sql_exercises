Find the top 2 highest paid City employees for each job title. Output the job title along with the corresponding highest and second-highest paid employees.


SELECT jobtitle,
       max(primus) AS best,
       max(secundum) AS second_best
FROM
  (SELECT jobtitle,
          CASE
              WHEN pos = 1 THEN employeename
              ELSE NULL
          END AS primus,
          CASE
              WHEN pos = 2 THEN employeename
              ELSE NULL
          END AS secundum
   FROM
     (SELECT employeename,
             jobtitle,
             totalpaybenefits,
             ROW_NUMBER() OVER (PARTITION BY jobtitle
                                ORDER BY totalpaybenefits DESC) AS pos
      FROM sf_public_salaries) one
   WHERE pos <= 2 ) two
GROUP BY jobtitle
