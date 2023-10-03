Find user id, language, and location of all Nexus 5 control group users in Italy who do not speak Italian. Sort the results in ascending order based on the occured_at value of the playbook_experiments dataset.

select pe.user_id, language, location from playbook_experiments pe inner join playbook_users pu on 
pe.user_id = pu.user_id
where location = 'Italy' and device = 'nexus 5' and language <> 'italian' and experiment_group = 'control_group'
order by occurred_at desc
