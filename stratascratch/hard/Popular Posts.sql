The column 'perc_viewed' in the table 'post_views' denotes the percentage of the session duration time the user spent viewing a post. Using it, calculate the total time that each post was viewed by users. Output post ID and the total viewing time in seconds, but only for posts with a total viewing time of over 5 seconds.


SELECT post_id,
       SUM(duration * (perc_viewed/100)::float) total_viewtime
FROM post_views p
JOIN
  (SELECT session_id,
          EXTRACT(EPOCH
                  FROM session_endtime::TIME) - EXTRACT(EPOCH
                                                        FROM session_starttime::TIME) AS duration
   FROM user_sessions)s ON p.session_id = s.session_id
GROUP BY post_id
HAVING SUM(duration * (perc_viewed/100)::float) > 5
