To improve sales, the marketing department runs various types of promotions. The marketing manager would like to analyze the effectiveness of these promotional campaigns. In particular, what percentage of sales had a valid promotion applied? Only the promotions found in the facebook_promotions table are valid.


select

count(fp.promotion_id)/count(*)::float *100.0 as percentage

from facebook_promotions fp right join facebook_sales fs on fp.promotion_id = fs.promotion_id
