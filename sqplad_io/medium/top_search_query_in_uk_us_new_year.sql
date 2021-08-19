/*
Write a query to return the top searched term in the US and UK 
on new year's day (2021-01-01), separately
The order of your results doesn't matter.
Rank them based on search volume.
*/


with help as (

select country, query,
row_number()over(partition by country order by count(query) desc ) as rank from search
where date = '2021-01-01'
group by country, query 
having country in ('UK', 'US'))


select country, query from help 
where rank = 1


-- official solution

SELECT
    country,
    query	
FROM (
    SELECT
        query,
        country,
        COUNT(DISTINCT user_id),
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY COUNT(DISTINCT user_id) DESC) AS row_num
    FROM search
    WHERE country IN ('US', 'UK')
    AND date = '2021-01-01'
    GROUP BY 1,2
) X
WHERE row_num = 1;
