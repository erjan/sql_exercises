Find how the average male height changed between each Olympics from 1896 to 2016.
Output the Olympics year, average height, previous average height, and the corresponding average height difference.
Order records by the year in ascending order.


If avg height is not found, assume that the average height of an athlete is 172.73.


SELECT 
    year, 
    COALESCE(AVG(height),172.73) as AVG_height,
    COALESCE(LAG(AVG(height)) OVER (ORDER BY year),172.73) as previous,
    COALESCE(AVG(height),172.73) - COALESCE(LAG(AVG(height)) OVER (ORDER BY year),172.73) as diff
FROM
        (
            SELECT
                year, 
                name, 
                MAX(height) as height
            FROM olympics_athletes_events
            WHERE sex = 'M'
            GROUP BY year, name
            ORDER BY year
        ) sq
GROUP BY year
