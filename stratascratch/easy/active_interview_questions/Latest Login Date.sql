For each video game player, find the latest date when they logged in.



select 
player_id,
max(login_date)

from players_logins group by player_id;
