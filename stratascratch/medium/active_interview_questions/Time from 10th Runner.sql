In a marathon, gun time is counted from the moment of the formal start of the race while net time is counted from the moment a runner crosses a starting line. Both variables are in seconds.


How much net time separates Chris Doe from the 10th best net time (in ascending order)? Avoid gaps in the ranking calculation. Output absolute net time difference.


WITH chris_doe AS
  (SELECT net_time
   FROM marathon_male
   WHERE person_name = 'Chris Doe'),
     tenth_runner AS
  (SELECT DISTINCT net_time
   FROM
     (SELECT *,
             dense_rank() OVER (
                                ORDER BY net_time ASC) rnk
      FROM marathon_male)a
   WHERE rnk = 10)
SELECT abs(t.net_time - c.net_time) difference
FROM tenth_runner t
CROSS JOIN chris_doe c
