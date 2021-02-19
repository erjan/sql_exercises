-- Сколько времени обучающийся будет находиться в школе, учась со 2-го по 4-ый уч. предмет ?

select timediff(  max(end_pair) , min(start_pair)) as time from timepair inner join schedule on schedule.number_pair = timepair.id
where number_pair between 2 and 4
