Meta/Facebook sends SMS texts when users attempt to 2FA (2-factor authenticate) into the platform to log in. In order to successfully 2FA they must confirm they received the SMS text message. Confirmation texts are only valid on the date they were sent.


Unfortunately, there was an ETL problem with the database where friend requests and invalid confirmation records were inserted into the logs, which are stored in the 'fb_sms_sends' table. These message types should not be in the table.


Fortunately, the 'fb_confirmers' table contains valid confirmation records so you can use this table to identify SMS text messages that were confirmed by the user.


Calculate the percentage of confirmed SMS texts for August 4, 2020.

select 

count(fc.phone_number)::float / count(sms.phone_number) * 100 as perc

from fb_sms_sends sms left join fb_confirmers fc  on
sms.ds  = fc.date and sms.phone_number = fc.phone_number

where sms.ds = '08-04-2020' and sms.type = 'message'

