

'''
  You’re given a table that represents search results from searches on Facebook. The query column is the search term, position column represents each position the search result came in, and the rating column represents the human rating from 1 to 5 where 5 is high relevance and 1 is low relevance.

Each row in the search_events table represents a single search with the has_clicked column representing if a user clicked on a result or not. We have a hypothesis that the CTR is dependent on the search result rating.

Write a query to return data to support or disprove this hypothesis.
  '''

WITH ratings AS (
    SELECT query
        , SUM(CASE WHEN 
                rating <= 1 THEN 1 ELSE 0 
            END) AS num_results_rating_one
        , SUM(CASE WHEN 
                rating <= 2 THEN 1 ELSE 0 
            END) AS num_results_rating_two
        , SUM(CASE WHEN 
                rating <= 3 THEN 1 ELSE 0 
            END) AS num_results_rating_three
        , COUNT(*) AS total_results
    FROM search_results
    GROUP BY 1
) 

SELECT
    CASE 
        WHEN total_results - num_results_rating_one = 0 
            THEN 'results_one'
        WHEN total_results - num_results_rating_two = 0 
            THEN 'results_two'
        WHEN total_results - num_results_rating_three = 0 
            THEN 'results_three'
    END AS ratings_bucket
    , SUM(has_clicked)/COUNT(*) AS ctr
FROM search_events AS se 
LEFT JOIN ratings AS r
    ON se.query = r.query
GROUP BY 1
