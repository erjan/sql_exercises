Find the vintage years of all wines from the country of Macedonia. The year can be found in the 'title' column. Output the wine (i.e., the 'title') along with the year. The year should be a numeric or int data type.


select 

title,
nullif(regexp_replace(title, '\D', '', 'g'),'')::numeric as year

from winemag_p2
where country = 'Macedonia'
