Find the number of a user's friends' friend who are also the user's friend. Output the user id along with the count.

WITH bidirectional_relationship AS
  (SELECT user_id,
          friend_id
   FROM google_friends_network
   UNION SELECT friend_id AS user_id,
                user_id AS friend_id
   FROM google_friends_network)
SELECT user_id,
       COUNT(DISTINCT friend_id) AS n_friends
FROM
  (SELECT DISTINCT a.user_id,
                   c.user_id AS friend_id
   FROM bidirectional_relationship a
   INNER JOIN bidirectional_relationship b ON a.friend_id = b.user_id
   INNER JOIN bidirectional_relationship c ON b.friend_id = c.user_id
   AND c.friend_id = a.user_id) base
GROUP BY user_id
