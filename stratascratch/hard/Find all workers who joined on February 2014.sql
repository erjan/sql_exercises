Find all workers who joined on February 2014.

select * from worker

where extract(year from joining_date) = 2014 and

extract(month from joining_date) = 2
