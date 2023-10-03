You are given a table of tennis players and their matches that they could either win (W) or lose (L). Find the longest streak of wins. A streak is a set of consecutive won matches of one player. The streak ends once a player loses their next match. Output the ID of the player or players and the length of the streak.


WITH cte AS
  (SELECT player_id,
          match_date,
          match_result,
     (SELECT COUNT(*)
      FROM players_results prev_results
      WHERE curr_results.player_id = prev_results.player_id
        AND prev_results.match_date <= curr_results.match_date
        AND prev_results.match_result <> curr_results.match_result) AS streak_id
   FROM players_results curr_results)

SELECT DISTINCT player_id,
                streak_length
FROM
  (SELECT player_id,
          match_result,
          streak_id,
          count(*) AS streak_length,
          rank() OVER (
                       ORDER BY count(*) DESC) AS rnk
   FROM cte
   WHERE match_result = 'W'
   GROUP BY player_id,
            match_result,
            streak_id
   ORDER BY player_id,
            streak_id) subquery
WHERE rnk = 1
