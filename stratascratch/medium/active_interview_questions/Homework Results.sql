Given the homework results of a group of students, calculate the average grade and the completion rate of each student. A homework is considered not completed if no grade has been assigned.
Output first name of a student, their average grade, and completion rate in percentages. Note that it's possible for several students to have the same first name but their results should still be shown separately.


with h as(
SELECT *, CASE
                 WHEN grade IS NULL THEN 0
                 ELSE 1
             END is_completed
   FROM allstate_homework)
   
  
  select student_firstname, avg(grade) avg_grade,
  sum(is_completed)/count(*)::float*100 as rate
  from h join allstate_students s on h.student_id = s.student_id
  group by s.student_id, student_firstname
