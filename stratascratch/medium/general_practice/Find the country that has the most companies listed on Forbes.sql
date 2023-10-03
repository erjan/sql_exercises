Find the country that has the most companies listed on Forbes.

Output the country along with the number of companies.


with h as(
select country, count(company) as x from forbes_global_2010_2014

group by country order by x desc)


select country,x from h where x = (select max(x) from h)
