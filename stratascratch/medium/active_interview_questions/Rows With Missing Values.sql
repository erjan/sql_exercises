The data engineering team at YouTube want to clean the dataset user_flags. In particular, they want to examine rows that have missing values in more than one column. List these rows.


select * 
from user_flags
where num_nulls(user_firstname, user_lastname, video_id, flag_id)>=2
