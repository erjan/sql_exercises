Find the variance of scores that have grade A using the formula AVG((X_i - mean_x) ^ 2).
Output the result along with the corresponding standard deviation.


SELECT
    AVG(x) AS variance,
    SQRT(AVG(X)) AS std
FROM
    (SELECT
        main.score,
        avgs.mean,
        (main.score - avgs.mean) * (main.score - avgs.mean) AS x
    FROM
        -- Averages table (a single value wrapped as table)
        (SELECT
            avg(score) AS mean
        FROM los_angeles_restaurant_health_inspections
        WHERE 
            score BETWEEN 90 AND 100) avgs,
        -- Main scores table
        los_angeles_restaurant_health_inspections main
    WHERE
        main.score BETWEEN 90 AND 100) tmp
