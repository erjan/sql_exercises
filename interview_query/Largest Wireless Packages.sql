


'''
  The table packet_rates contains data about wireless packages sent from multiple devices to different networks (SSID).

Write a query that returns, for each SSID, the largest number of packages sent by a single device in the first 10 minutes of January 1st, 2022.
  '''

select ssid, max(pck_cnt) as max_number_of_packages_sent from (

select ssid, mac_address, count(*) as pck_cnt from packet_rates

where 
time_captured between '2022-01-01 00:00:00' and '2022-01-01 00:10:00'


group by ssid, mac_address)k

group by ssid
