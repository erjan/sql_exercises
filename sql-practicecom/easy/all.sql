Show first name, last name, and gender of patients who's gender is 'M'

SELECT first_name,last_name,gender FROM patients where gender = 'M'
------------------------

Show first name and last name of patients who does not have allergies. (null)

SELECT first_name,last_name FROM patients where allergies is null

--------------------------------------
