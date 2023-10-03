Calculate the average session duration for each session type?



select


session_type, 


avg(session_end - session_start)


from twitch_sessions
group by session_type
