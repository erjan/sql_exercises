/*
Write a query to compute the click through rate for the search results on new year's day (2021-01-01).
Click through rate: number of searches end up with at least one click.
Convert your result into a percentage (* 100.0).

не мог понять что такое "миним. 1 клик" - это просто посчитать, я думал что там есть поиски когда был одновремено действие и клик и импресс"
*/

with h1 as (

select * from search_result

where extract(year from date) = 2021 and extract(day from date) = 1
and extract(month from date) = 1)


SELECT 
COUNT(DISTINCT CASE WHEN action = 'click' THEN search_id ELSE NULL END) * 100.0/COUNT(DISTINCT search_id)
from h1
