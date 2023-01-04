Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

select 
count(patient_id),
floor(weight/10)*10 as weight_group
from patients
group by weight_group
order by weight_group desc
-------------------------------------------------------------------------------------------------------------------------------------
Show patient_id, weight, height, isObese from the patients table.

Display isObese as a boolean 0 or 1.

Obese is defined as weight(kg)/(height(m)2) >= 30.

weight is in units kg.

height is in units cm.

select 
patient_id, weight,height,
case when weight/power(height/100.0,2) >=30 then 1 else 0 end as isObese
from patients
-------------------------------------------------------------------------------------------------------------------------------------
Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

Check patients, admissions, and doctors tables for required information.

select 
p.patient_id, p.first_name, p.last_name, d.specialty
from patients p join admissions a on p.patient_id = a.patient_id join 
doctors d on d.doctor_id = a.attending_doctor_id
where diagnosis = 'Epilepsy' and d.first_name = 'Lisa'

-------------------------------------------------------------------------------------------------------------------------------------
All patients who have gone through admissions, can see their medical documents on our site. Those patients 
are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

select 

distinct p.patient_id, concat(p.patient_id,len(p.last_name), year(p.birth_date) ) as temp_password
from patients p join admissions a on p.patient_id = a.patient_id 
-------------------------------------------------------------------------------------------------------------------------------------
Each admission costs $50 for patients without insurance, and $10 for patients with insurance. 
All patients with an even patient_id have insurance.

Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. 
Add up the admission_total cost for each has_insurance group.
SELECT 
CASE WHEN patient_id % 2 = 0 Then 
    'Yes'
ELSE 
    'No' 
END as has_insurance,
SUM(CASE WHEN patient_id % 2 = 0 Then 
    10
ELSE 
    50 
END) as cost_after_insurance
FROM admissions 
GROUP BY has_insurance;
-------------------------------------------------------------------------------------------------------------------------------------
Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

with h as(SELECT 
p2.province_name,

sum(case when gender = 'M' then 1 end) as male,
sum(case when gender = 'F' then 1 end) as female

from patients p join province_names p2 on p.province_id = p2.province_id

group by p2.province_name)


select province_name   from h

where male > female

-------------------------------------------------------------------------------------------------------------------------------------
We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'


select *
from patients where weight between 60 and 80
and patient_id %2 =1 and city = 'Kingston' and gender = 'F' 
and first_name like '__r%' and month(birth_date) in (2,5,12)

-------------------------------------------------------------------------------------------------------------------------------------
Show the percent of patients that have 'M' as their gender. Round the answer to 
the nearest hundreth number and in percent form.
select 
concat(round(100.0* sum(case when gender = 'M' then 1 end) / count(*) ,2), '%') as percent_of_male_patients
from patients


-------------------------------------------------------------------------------------------------------------------------------------
For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
select 
admission_date,
count(*),
count(*) -lag(count(*),1)over(order by admission_date) 
from admissions
group by admission_date

-------------------------------------------------------------------------------------------------------------------------------------
Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
select 
province_name
from province_names
order by  province_name = 'Ontario' desc, province_name


