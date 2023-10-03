Find the 80th percentile of hours studied. Output hours studied value at specified percentile.





select 

percentile_cont(0.8)within group(order by hrs_studied) as perc
from sat_scores;
