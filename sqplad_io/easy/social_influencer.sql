/*
Write a query to return the user's id with the most friends.
Hint:We can assume there is one and only one person with the most friends, there is no tie.
A request can be accepted multiple times.
*/


SELECT recipient_id
FROM accepted_request
GROUP BY recipient_id
ORDER BY COUNT(distinct sender_id) DESC
LIMIT 1;
