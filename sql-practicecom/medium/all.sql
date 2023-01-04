
Show unique birth years from patients and order them by ascending.
select distinct year(birth_date) as year from patients order by year 

------------------------------------------------------------------------------------------------------------
Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name
in the output list. If only 1 person is named 'Leo' then include them in the output.

select distinct(first_name)  from 

patients 
group by first_name having count(*) = 1

------------------------------------------------------------------------------------------------------------
Show patient_id and first_name from patients where their first_name start and ends with 's' and is 
at least 6 characters long.

select patient_id, first_name from patients where first_name like 's%s' and len(first_name)>=6


------------------------------------------------------------------------------------------------------------

Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.

select p.patient_id, first_name, last_name from patients p join admissions a on p.patient_id = a.patient_id
where diagnosis = 'Dementia'




------------------------------------------------------------------------------------------------------------

Display every patient's first_name.
Order the list by the length of each name and then by alphbetically

select first_name from patients p order by len(first_name) , first_name



------------------------------------------------------------------------------------------------------------

Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.

select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients;







------------------------------------------------------------------------------------------------------------
Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results 
ordered ascending by allergies then by first_name then by last_name.

select first_name,last_name,allergies
 
 from patients where allergies in ('Penicillin' , 'Morphine')
 
 order by allergies, first_name,last_name





------------------------------------------------------------------------------------------------------------


Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.



select 
patient_id, diagnosis from admissions
group by diagnosis,patient_id
having count(*)>1





------------------------------------------------------------------------------------------------------------

Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.


select 

city, count(patient_id) as x from patients
group by city
order by x desc, city






------------------------------------------------------------------------------------------------------------


Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"


select 

 first_name,last_name,'Patient' from patients 
 union all
 
 select 

 first_name,last_name,'Doctor' from doctors




------------------------------------------------------------------------------------------------------------

Show all allergies ordered by popularity. Remove NULL values from query.




select 
allergies, count(*) as total_diagnosis
 from patients  where allergies is not null  group by allergies order by total_diagnosis desc
 
 





------------------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------------------












------------------------------------------------------------------------------------------------------------












------------------------------------------------------------------------------------------------------------











------------------------------------------------------------------------------------------------------------













------------------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------------------











------------------------------------------------------------------------------------------------------------









------------------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------------------









------------------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------------------









------------------------------------------------------------------------------------------------------------

