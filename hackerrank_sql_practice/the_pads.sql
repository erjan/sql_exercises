/*

Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed 
by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). 
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences 
in ascending order, and output them in the following format:

*/


select concat(name, '(', substring(occupation,1,1 ), ')' ) from occupations order by name ;

select concat('There are a total of ', r ,' ',lcase(occupation), 's.')  from (
select occupation, count(occupation) as r from occupations group by occupation )k order by r;
