


'''
To finish a class, students must pass four exams (exam ids: 1,2,3 and 4).

Given a table exam_scores containing the data about all of the exams that students took, form a new table to track the scores for each student.

Note: Students took each exam only once.
'''


with h as(
SELECT 
student_name,
case when exam_id = 1 then score end as exam_1,
case when exam_id = 2 then score end as exam_2,
case when exam_id = 3 then score end as exam_3,
case when exam_id = 4 then score end as exam_4



 FROM exam_scores)


 select student_name, max(exam_1) exam_1, max(exam_2)exam_2, 
 max(exam_3)exam_3, max(exam_4)exam_4 from h group by student_name
