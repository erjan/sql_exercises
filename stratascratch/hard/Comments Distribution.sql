Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020, for the month of January 2020.


The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. Your left column in the output will be the number of comments while your right column in the output will be the number of users. Sort the output from the least number of comments to highest.


To add some complexity, there might be a bug where an user post is dated before the user join date. You'll want to remove these posts from the result.


with h as(
select fu.id as user_id, body as comment from fb_users fu inner join fb_comments fc
on fu.id = fc.user_id where joined_at < created_at
and joined_at between '2018-01-01' and '2020-12-31' 
and created_at between '2020-01-01' and '2020-01-31'),

h2 as(
select 

count(comment) as n_comments,user_id
from h group by user_id)


select n_comments, count(user_id) from h2 group by n_comments

