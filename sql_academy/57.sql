-- Перенести расписание всех занятий на 30 мин. вперед.
update Timepair

SET start_pair = DATE_ADD(start_pair, INTERVAL 30 MINUTE),
 end_pair= DATE_ADD(end_pair, INTERVAL 30 MINUTE)
