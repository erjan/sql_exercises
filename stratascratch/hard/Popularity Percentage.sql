Find the popularity percentage for each user on Meta/Facebook. The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
The 'user1' and 'user2' column are pairs of friends.

SELECT user1, 
    (count(user2)/count(1) over()::decimal*100) as popularity_percentage
FROM (
    select user1, user2
    from facebook_friends
    UNION ALL
    select user2, user1
    from facebook_friends) as l
GROUP BY user1
ORDER BY user1
