Find the nominee who has won the most Oscars.
Output the nominee's name alongside the result.



with h as(
select 

nominee, count(*) as x
from oscar_nominees
where winner = TRUE
group by nominee)


select nominee, x as n_times_won from h where x = (select max(x) from h)

