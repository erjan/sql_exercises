Find districts alongside their crime incidents.
Output the district name alongside the number of crime occurrences.
Order records based on the number of occurrences in descending order.



select pd_district, count(incidnt_num) as x



from sf_crime_incidents_2014_01

group by pd_district

order by x desc
