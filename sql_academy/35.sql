-- Сколько различных кабинетов школы использовались 2.09.2019 в образовательных целях ?


select count (distinct classroom) as count from schedule where
extract(year from date) = 2019 and extract( day from date) =2 and extract( month from date)  =  9 
