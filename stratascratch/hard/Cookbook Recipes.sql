You are given the table with titles of recipes from a cookbook and their page numbers. You are asked to represent how the recipes will be distributed in the book.
Produce a table consisting of three columns: left_page_number, left_title and right_title. The k-th row (counting from 0), should contain the number and the title of the page with the number 2 \times k2×k in the first and second columns respectively, and the title of the page with the number 2 \times k + 12×k+1 in the third column.
Each page contains at most 1 recipe. If the page does not contain a recipe, the appropriate cell should remain empty (NULL value). Page 0 (the internal side of the front cover) is guaranteed to be empty.




with h as(

select min(page_number) as minp, max(page_number) as maxp from cookbook_titles),

minp as(
select minp from h),
maxp as(
select maxp from h),

gen as(
select generate_series as pnum from generate_series( (select * from minp),
(select  * from maxp))),

cook2 as(
select gen.pnum, c.title from gen left join cookbook_titles c  on gen.pnum = c.page_number)


select (row_number()over(order by pnum/2)-1)*2 as left_page_number ,

string_agg(case when pnum %2 = 0 then title end, ',') as left_title,
string_agg(case when pnum%2 = 1 then title end, ',') as right_title

from cook2
group by pnum/2
