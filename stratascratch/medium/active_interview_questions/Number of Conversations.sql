Count the total number of distinct conversations on WhatsApp. Two users share a conversation if there is at least 1 message between them. Multiple messages between the same pair of users are considered a single conversation.



select count(*) as num from (
select message_sender_id as u1, message_receiver_id as u2 from whatsapp_messages
union 
select message_receiver_id as u1, message_sender_id as u2 from whatsapp_messages)k
where u1 < u2
