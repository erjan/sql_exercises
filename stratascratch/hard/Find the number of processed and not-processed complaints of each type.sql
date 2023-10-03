Find the number of processed and non-processed complaints of each type.
Replace NULL values with 0s.
Output the complaint type along with the number of processed and not-processed complaints.

with h as(
select 

complaint_id,
type, 
(case when processed = TRUE then 1 else 0 end) as yes_proc,
(case when processed = FALSE then 1 else 0 end) as no_proc

from facebook_complaints)


select type, sum(yes_proc), sum(no_proc)
 from h group by type
