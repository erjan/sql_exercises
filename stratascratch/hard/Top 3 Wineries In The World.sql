
Find the top 3 wineries in each country based on the average points earned. In case there is a tie, order the wineries by winery name in ascending order. Output the country along with the best, second best, and third best wineries. If there is no second winery (NULL value) output 'No second winery' and if there is no third winery output 'No third winery'. For outputting wineries format them like this: "winery (avg_points)"


SELECT country,
       max(top_winery) AS top_winery,
       COALESCE(max(second_winery), 'No second winery') AS second_winery,
       COALESCE(max(third_winery), 'No third winery') AS third_winery
FROM
  (SELECT country,
          CASE
              WHEN POSITION = 1 THEN winery || ' (' || round(avg_points) || ')'
              ELSE NULL
          END AS top_winery,
          CASE
              WHEN POSITION = 2 THEN winery || ' (' || round(avg_points) || ')'
              ELSE NULL
          END AS second_winery,
          CASE
              WHEN POSITION = 3 THEN winery || ' (' || round(avg_points) || ')'
              ELSE NULL
          END AS third_winery
   FROM
     (SELECT country,
             winery,
             ROW_NUMBER() OVER (PARTITION BY country
                                ORDER BY avg_points DESC, winery ASC) AS POSITION,
                               avg_points
      FROM
        (SELECT country,
                winery,
                avg(points) AS avg_points
         FROM winemag_p1
         WHERE country IS NOT NULL
         GROUP BY country,
                  winery) tmp1) tmp2
   WHERE POSITION <= 3) tmp3
GROUP BY country
