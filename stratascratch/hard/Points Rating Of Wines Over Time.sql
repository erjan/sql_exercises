Find the average points difference between each and previous years starting from the year 2000. Output the year, average points, previous average points, and the difference between them.
If you're unable to calculate the average points rating for a specific year, use an 87 average points rating for that year (which is the average of all wines starting from 2000).


select year,avg_points, coalesce(lag(avg_points) over(order by year),87) as prev_avg_points,avg_points - coalesce(lag(avg_points) over(order by year),87) as difference from
(select year,avg(points) as avg_points from
(SELECT points,
             substring(title, '20[\d]{2}'):: integer AS YEAR
      FROM winemag_p2
      WHERE points IS NOT NULL
        AND title IS NOT NULL) main
        group by year) tmp 
        where year>2000
        order by year
