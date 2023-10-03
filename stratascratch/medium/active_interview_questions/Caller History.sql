Given a phone log table that has information about callers' call history, find out the callers whose first and last calls were to the same person on a given day. Output the caller ID, recipient ID, and the date called.


WITH first_and_last AS
  (SELECT *,
          FIRST_VALUE(recipient_id) OVER(PARTITION BY caller_id, DATE(date_called)
                                         ORDER BY date_called ASC) AS first_call,
          FIRST_VALUE(recipient_id) OVER(PARTITION BY caller_id, DATE(date_called)
                                         ORDER BY date_called DESC) AS last_call
   FROM caller_history)
SELECT DISTINCT caller_id,
                first_call AS recipient,
                DATE(date_called)
FROM first_and_last
WHERE first_call = last_call
