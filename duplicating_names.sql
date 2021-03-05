-- this finds repeating names in table with fields - id, name:

SELECT name, count(*) 
FROM table
GROUP BY name
HAVING COUNT(*) > 1


-- this will print like this, very useful to find duplicating names

Adam 2 
Alan 6 
Albert 4 
Amy 5 
Andrew 3 
Angela 2 
