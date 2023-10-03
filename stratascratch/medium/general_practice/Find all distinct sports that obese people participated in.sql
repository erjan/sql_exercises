Find all distinct sports that obese people participated in.
A person is considered as obese if his or her body mass index exceeds 30.
The body mass index is calculated as weight / (height * height). Use meters for height and kilograms for weight.


with h as(
select 
*,
cast(weight as int)/((height/100)*(height/100)) as bmi
from olympics_athletes_events
where weight is not null and height is not null)


select distinct sport from h where bmi > 30
