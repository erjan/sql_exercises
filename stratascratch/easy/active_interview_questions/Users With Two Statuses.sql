Find users who are both a viewer and streamer.



select distinct user_id


from twitch_sessions

where session_type  in ('viewer','streamer')
