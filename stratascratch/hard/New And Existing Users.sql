Calculate the share of new and existing users for each month in the table. Output the month, share of new users, and share of existing users as a ratio.
New users are defined as users who started using services in the current month (there is no usage history in previous months). Existing users are users who used services in current month, but they also used services in any previous month.
Assume that the dates are all from the year 2020.


with h as(
select *, extract(month from time_id ) as month from fact_events),

all_users as(
select
month, count(distinct user_id) as all_users from h group by month),


new_users as(
 SELECT date_part('month', new_user_start_date) AS month,
          count(DISTINCT user_id) as new_users FROM(

         SELECT user_id,
           min(time_id) as new_user_start_date
          FROM fact_events
          GROUP BY user_id
          ) sq GROUP BY month)
          
select a.month, 

n.new_users/a.all_users::float as share_new_users,
1-n.new_users/a.all_users::float as share_new_users


from all_users a join new_users n on a.month = n.month           
