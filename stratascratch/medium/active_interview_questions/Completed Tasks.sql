Find the number of actions that ClassPass workers did for tasks completed in January 2022. The completed tasks are these rows in the asana_actions table with 'action_name' equal to CompleteTask. Note that each row in the dataset indicates how many actions of a certain type one user has performed in one day and the number of actions is stored in the 'num_actions' column.
Output the ID of the user and a total number of actions they performed for tasks they completed. If a user from this company did not complete any tasks in the given period of time, you should still output their ID and the number 0 in the second column.


with class_pass_workers as(
SELECT
au.user_id FROM asana_users au  where company = 'ClassPass' ),


users_completed_jan2022 as(
select user_id, sum(num_actions) as total_actions from asana_actions au where date between '2022-01-01' and '2022-01-31'
and action_name = 'CompleteTask'
group by user_id)

select w.user_id, coalesce(total_actions,0) from users_completed_jan2022 u right join class_pass_workers w 
on u.user_id = w.user_id
