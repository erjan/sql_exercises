Find the unique room types(filter room types column). Output each unique room types in its own row.



select 


distinct unnest(string_to_array(btrim(filter_room_types, ',') , ','))


from airbnb_searches;
