Find the average host response rate with a cleaning fee for each zipcode. Present the results as a percentage along with the zip code value.
Convert the column 'host_response_rate' from TEXT to NUMERIC using type casts and string processing (take missing values as NULL).
Order the result in ascending order based on the average host response rater after cleaning.



SELECT zipcode,
       avg(tmp.clean_host_response_rate) AS avg_host_response_rate
FROM
  (SELECT zipcode,
          cleaning_fee,
          (CASE
               WHEN host_response_rate IS NULL THEN NULL
               ELSE SUBSTR(host_response_rate, 0, POSITION ('%' IN host_response_rate))
           END) :: NUMERIC AS clean_host_response_rate
   FROM airbnb_search_details
   WHERE cleaning_fee = TRUE) tmp
GROUP BY zipcode
HAVING avg(tmp.clean_host_response_rate) IS NOT NULL
ORDER BY avg_host_response_rate
