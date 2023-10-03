Create a report showing how many views each keyword has. Output the keyword and the total views, and order records with highest view count first.

SELECT unnest(string_to_array(BTRIM(post_keywords, '[]#'),',')) as keyword
        ,COUNT(viewer_id)
FROM facebook_posts fp
LEFT JOIN  facebook_post_views fpv
    ON fp.post_id = fpv.post_id
GROUP BY 1
ORDER BY COUNT(viewer_id) DESC
