Output ids of students with a median score from the writing SAT.






select student_id, percentile_cont(0.5)within group(order by sat_writing) as writing_perc from sat_scores

