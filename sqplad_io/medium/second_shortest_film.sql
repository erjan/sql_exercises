Write a query to return the title of the second shortest film based on its duration/length.
A movie's duration can be found using the length column.
If there are ties, return just one of them.

    select title from film order by length asc limit 1  offset 1
