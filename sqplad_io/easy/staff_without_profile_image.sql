Write a SQL query to return this staff's first name and last name.
Picture field contains the link that points to a staff's profile image.
There is only one staff who doesn't have a profile picture.
Use colname IS NULL to identify data that are missing.


SELECT first_name, last_name
FROM staff where picture is null

    
