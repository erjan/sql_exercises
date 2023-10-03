Find the hometowns with the top 3 average net times. Output the hometowns and their average net time. In case there are ties in net time, return all unique hometowns.


select  hometown, av from (
select hometown, avg(net_time) as av, 
dense_rank()over(order by avg(net_time) ) as rnk


from marathon_male

group by hometown)k where rnk <=3
