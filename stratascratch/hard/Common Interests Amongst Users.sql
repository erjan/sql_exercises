Count the subpopulations across datasets. Assume that a subpopulation is a group of users sharing a common interest (ex: Basketball, Food). Output the percentage of overlapping interests for two posters along with those poster's IDs. Calculate the percentage from the number of poster's interests. The poster column in the dataset refers to the user that posted the comment.


SELECT 
    a.poster, 
    MIN(b.poster),
    COUNT(b.interest) * 1.0 / COUNT(a.interest) as rate
FROM

        (
            select 
                poster, 
                UNNEST(STRING_TO_ARRAY(translate(post_keywords, '[]', ''),',')) as interest
            from facebook_posts
            WHERE post_keywords not ilike '%spam%'
        ) a
 LEFT JOIN   
        (
            select 
                poster, 
                UNNEST(STRING_TO_ARRAY(translate(post_keywords, '[]', ''),',')) as interest
            from facebook_posts
            WHERE post_keywords not ilike '%spam%'
        ) b
ON a.interest = b.interest AND a.poster != b.poster
GROUP BY a.poster
