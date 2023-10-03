Calculate the first-day retention rate of a group of video game players. The first-day retention occurs when a player logs in 1 day after their first-ever log-in.
Return the proportion of players who meet this definition divided by the total number of players.


WITH CTE as  
    (
        SELECT * FROM 
            (    
                 select 
                    player_id,
                    login_date,
                    LEAD(login_date) OVER (PARTITION BY 
                        player_id ORDER BY login_date) as next, 
                    ROW_NUMBER() OVER (PARTITION BY 
                        player_id ORDER BY login_date) as rnk
                from players_logins
                GROUP BY 
                    player_id,
                    login_date
            ) sq
    WHERE next = login_date + INTERVAL '1 day' AND rnk = 1
    )

SELECT 
    (SELECT COUNT(*) FROM CTE) * 1.0 / COUNT(DISTINCT player_id)  
FROM players_logins;
