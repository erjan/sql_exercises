Find stores that were opened in the second half of 2021 with more than 20% of their reviews being negative. A review is considered negative when the score given by a customer is below 5. Output the names of the stores together with the ratio of negative reviews to positive ones.


WITH ratings AS (
SELECT
 istr.name,
 COUNT(*) AS all_reviews,
 SUM(CASE WHEN ir.score < 5 THEN 1 ELSE 0 END) AS negative_reviews,
 SUM(CASE WHEN ir.score >= 5 THEN 1 ELSE 0 END) AS positive_reviews
FROM instacart_stores istr
JOIN instacart_reviews ir
 ON istr.id = ir.store_id
WHERE istr.opening_date BETWEEN '2021-07-01' AND '2021-12-31'
GROUP BY 1
),
negative_overview AS (
SELECT
 name,
 100*(negative_reviews/all_reviews::float) AS negative_prcnt,
 negative_reviews/(positive_reviews)::float AS negative_ratio
FROM ratings
)
SELECT
 no.name,
 negative_ratio
FROM negative_overview no
JOIN ratings r 
 ON no.name = r.name
WHERE negative_prcnt > 20
