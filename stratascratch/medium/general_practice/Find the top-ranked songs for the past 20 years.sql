Find all the songs that were top-ranked (at first position) at least once in the past 20 years



select 

distinct song_name
from billboard_top_100_year_end

where year_rank =1 and DATE_PART('year', CURRENT_DATE) - year <=20
