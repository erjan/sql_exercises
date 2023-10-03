Find the number of interactions along with the number of people involved with them on a given day. Output the date along with the number of interactions and people. Order results based on the date in ascending order and the number of people in descending order.






with interaction_one_column as (
    select day, 
            user1 as main_user
            from facebook_user_interactions
    union all 
    select day, 
            user2 as main_user
            from facebook_user_interactions
    )
    
select day, 
        count(*)/2 as n_interactions, 
        count(distinct main_user) as n_users
        from interaction_one_column
        group by 1
        order by 1, 3 DESC
