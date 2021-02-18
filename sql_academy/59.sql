 -- Print users who have a Belarusian phone number? The telephone code of Belarus is +375.

select * from users where phone_number like '+375%'
