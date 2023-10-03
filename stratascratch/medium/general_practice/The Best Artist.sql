Find the number of times an artist has been on the billboard top 100 in the past 20 years. Output the result alongside the artist's name and order records based on the founded count in descending order.


select artist , count(*) as x


from billboard_top_100_year_end
where date_part('year', CURRENT_DATE) -year <= 20

group by artist

order by x desc
