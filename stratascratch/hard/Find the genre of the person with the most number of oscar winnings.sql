Find the genre of the person with the most number of oscar winnings.
If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. Use the names as keys when joining the tables.

with h as(
select 
nominee,
count(*)over(partition by nominee) as oscar_wins


from oscar_nominees on1 
where winner = TRUE order by oscar_wins desc , nominee asc limit 1)


select top_genre
from h inner join nominee_information info on h.nominee = info.name
